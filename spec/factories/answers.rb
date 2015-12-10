FactoryGirl.define do
  factory :answer do
    content {Faker::Lorem.word}
    is_correct true
  end
end
