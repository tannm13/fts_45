class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :answers
  has_many :exams, through: :results
  has_many :results

  enum status: {inactive: 0, active: 1}
  enum type: {single: 0, multiple: 1, text: 2}
  accepts_nested_attributes_for :answers,
    reject_if: ->attributes{attributes["content"].blank?},
    allow_destroy: true
end
