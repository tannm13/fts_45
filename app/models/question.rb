class Question < ActiveRecord::Base
  enum question_type: {single: 0, multi: 1, text: 2}
  enum status: {inactive: 0, active: 1}

  belongs_to :user
  belongs_to :subject
  has_many :answers
  has_many :exams, through: :results
  has_many :results

  accepts_nested_attributes_for :answers,
    reject_if: ->attributes{attributes["content"].blank?},
    allow_destroy: true
end
