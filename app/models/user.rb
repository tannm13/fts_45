class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  enum role: {normal: 1, admin: 0}

  has_many :exams
  has_many :questions
end
