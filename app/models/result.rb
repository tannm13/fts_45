class Result < ActiveRecord::Base
  serialize :answer_content, Array

  belongs_to :exam
  belongs_to :question

  scope :correct, -> {where is_correct: true}

  before_update :clean_answer_content

  private
  def clean_answer_content
    attributes["answer_content"].delete ""
  end
end
