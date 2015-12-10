FactoryGirl.define do
  factory :user do
    name  {Faker::Name.name}
    email {Faker::Internet.email}
    password "12345678"
    role 0
  end
end
