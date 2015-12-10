require "rails_helper"

describe User do

  subject {build :user}

  it {is_expected.to respond_to :name}
  it {is_expected.to respond_to :email}
  it {is_expected.to respond_to :password}
  it {is_expected.to respond_to :role}

  it {is_expected.to be_valid}
  it {is_expected.to be_admin}

  describe "#name" do
    before {subject.name = ""}
    it {is_expected.to have(1).error_on :name}
  end

  describe "#email" do
    context "wrong format" do
      before {subject.email = "aaa@@@@(***FFDJF"}
      it {is_expected.to have(1).error_on :email}
    end

    context "empty" do
      before {subject.email = ""}
      it {is_expected.to have(1).error_on :email}
    end

    context "existed" do
      before {@another_user = create :user}
      it {is_expected.to have(1).error_on :email}
    end
  end

  describe "#password" do
    context "empty" do
      before {subject.password = ""}
      it {is_expected.to have(1).error_on :password}
    end

    context "too short" do
      before {subject.password = "12345"}
      it {is_expected.to have(1).error_on :password}
    end
  end

  describe "association" do
    it {is_expected.to have_many :exams}
    it {is_expected.to have_many :questions}
  end
end
