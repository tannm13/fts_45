require "rails_helper"

describe "questions/new.html.erb" do
  subject {rendered}
  let(:user) {build :user}
  let(:question) {build :question}
  let(:subject) {build :subject}

  before do
    sign_in user
    assign :question, question
    assign :subjects, subject
    render
  end

  it do
    is_expected.to have_selector "form", method: "post", action: question_path do |form|
      form.is_expected.to have_selector "input", name: "status"
      form.is_expected.to have_selector "input", name: "name"
      form.is_expected.to have_selector "select", name: "subject_id"
      form.is_expected.to have_selector "select", name: "question_type"
      form.is_expected.to have_selector "input", type: "submit"
    end
  end

end
