class Exam < ActiveRecord::Base
  include StateAble
  include PublicActivity::Model
  enum status: {start: 0, testing: 1, saved: 2, unchecked: 3, checked: 4}
  tracked except: :update,
    owner: ->(controller, model) {controller && controller.current_user}

  belongs_to :subject
  belongs_to :user
  has_many :questions, through: :results
  has_many :results

  scope :fake, ->{where "created_at <= ?", Settings.day.day.ago}
  scope :recent, -> {order created_at: :desc}

  accepts_nested_attributes_for :results

  before_create :init_exam
  after_update :set_score, if: :checked?
  after_update :send_exam_result, if: :unchecked?

  def time_remaining
    Settings.exam.duration * Settings.seconds - self.spent_time
  end

  def time_spent
    self.spent_time + (Time.zone.now - self.updated_at).to_i
  end

  def calculated_score
    self.results.correct.count
  end

  def auto_check
    self.results.each do |result|
      question = result.question
      if question.text?
        result.update_attributes is_correct: true if
          question.answers[0].content == result.answer_content[0]
      else
        result.update_attributes is_correct: true if
          (result.question.answers.correct.ids.map{|id| id.to_s} -
          result.answer_content).empty?
      end
    end
    self.update_status :checked
  end

  private
  def init_exam
    self.questions = self.subject.questions.active
      .order("RANDOM()").limit Settings.exam.question_number
  end

  def set_score
    self.update_column :score, self.calculated_score
  end

  def send_exam_result
    SendExamResult.perform_async self.id
  end
end
