require "rails_helper"

describe ExamsController do
  let(:exam) {create :exam}
  let(:user) {create :user}
  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET index" do
    before {get :index}
    it {expect(response).to render_template :index}
    it {expect(response.status).to eq 200}
  end

  describe "GET show" do
    before {get :show, id: exam}
    it {expect(response).to render_template :show}
    it {expect(response.status).to eq 200}
  end

  describe "POST create" do
    before do
      Exam.skip_callback :create, :before, :init_exam
      post :create, exam: attributes_for(:exam)
    end

    context "when exam saves successfully" do
      it {expect(flash[:success]).to be_present}
      it {expect(response).to render_template :index}
    end

    context "when exam fails to save" do
      it {expect(flash[:danger]).to be_present}
      it {expect(response).to render_template :index}
    end
  end

  describe "PATCH update" do
    before do
      patch :update, exam: attributes_for(:exam), id: exam
    end

    context "when exam saves successfully" do
      it {expect(flash[:success]).to be_present}
      it {expect(response).to render_template :index}
    end

    context "when exam fails to save" do
      it {expect(flash[:danger]).to be_present}
      it {expect(response).to render_template :index}
    end
  end

end
