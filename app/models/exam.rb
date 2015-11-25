class Exam < ActiveRecord::Base
  enum status: {start: 0, testing: 1, unchecked: 2, checked: 3}

  belongs_to :subject
  belongs_to :user
  has_many :questions, through: :results
  has_many :results

  before_create :init_exam

  private
  def init_exam
    self.questions = self.subject.questions.order("RANDOM()").
      limit Settings.exam.question_number
  end
end
