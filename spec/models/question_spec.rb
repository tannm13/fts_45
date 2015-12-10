require "rails_helper"

describe Question do

  subject {build :question}

  it {is_expected.to respond_to :name}
  it {is_expected.to be_valid}

  describe "#name" do
    context "invalid name" do
      before {subject.name = ""}
      it {is_expected.to have(1).error_on :name}
    end
  end

  describe "association" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :subject}
    it {is_expected.to have_many :answers}
    it {is_expected.to have_many(:exams).through :results}
    it {is_expected.to have_many :results}
  end
end
