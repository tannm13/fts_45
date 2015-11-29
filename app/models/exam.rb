class Exam < ActiveRecord::Base
  include StateAble
  enum status: {start: 0, testing: 1, saved: 2, unchecked: 3, checked: 4}

  belongs_to :subject
  belongs_to :user
  has_many :questions, through: :results
  has_many :results

  scope :recent, -> {order created_at: :desc}

  accepts_nested_attributes_for :results

  before_create :init_exam

  def time_remaining
    Settings.exam.duration * Settings.seconds - self.spent_time
  end

  def time_spent
    self.spent_time + (Time.zone.now - self.updated_at).to_i
  end

  private
  def init_exam
    self.questions = self.subject.questions.active
      .order("RANDOM()").limit Settings.exam.question_number
  end
end
