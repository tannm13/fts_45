require "rails_helper"

describe "exams/index.html.erb" do
  let(:user) {create :user}
  let(:subject) {create :subject}
  let(:exam) {create :exam, subject: subject, user: user}

  before do
    sign_in user
    assign :exam, exam
    assign :exams, user.exams.paginate(page: 1)
    assign :subjects, [subject]
    render
  end

  it do
    expect(controller.request.path_parameters[:controller]).to eq("exams")
    expect(controller.request.path_parameters[:action]).to eq("index")
    expect(controller.controller_path).to eq("exams")
  end

  it do
    expect(rendered).to have_selector "form" do |form|
      form.is_expected.to have_selector "input", name: "user_id"
      form.is_expected.to have_selector "input", name: "status"
      form.is_expected.to have_selector "input", name: "duration"
      form.is_expected.to have_selector "input", name: "question_number"
      form.is_expected.to have_selector "select", name: "subject_id"
      form.is_expected.to have_selector "input", type: "submit"
    end
  end

  it do
    expect(rendered).to have_content exam.subject.name
    expect(rendered).to have_content exam.status
    expect(rendered).to have_content exam.duration
    expect(rendered).to have_content exam.question_number
    expect(rendered).to have_content exam.spent_time
    expect(rendered).to have_content exam.score
  end
end
