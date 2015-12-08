FactoryGirl.define do
  factory :user do
    name  {Faker::Name.name}
    email "admin@framgia.com"
    password "12345678"
    role 0
  end
end
