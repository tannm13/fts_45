class Exam < ActiveRecord::Base
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
