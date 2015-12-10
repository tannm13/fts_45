FactoryGirl.define do
  factory :exam do
    subject {FactoryGirl.create :subject}
    user {FactoryGirl.create :user}
  end
end
