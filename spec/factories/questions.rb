FactoryGirl.define do
  factory :question do
    name Faker::Lorem.word
    user {FactoryGirl.create :user}
    subject {FactoryGirl.create :subject}
    question_type :single
    status :inactive
  end
end
