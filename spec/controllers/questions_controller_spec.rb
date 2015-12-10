require "rails_helper"

describe QuestionsController do
  let(:question) {create :question}
  let(:subjects) {build :subject}
  let(:user) {build :user}
  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET index" do
    before {get :index}
    it {expect(response).to render_template :index}
    it {expect(response.status).to eq 200}
  end

  describe "GET edit" do
    before {get :edit, id: question}
    it {expect(response).to render_template :edit}
    it {expect(response.status).to eq 200}
  end

  describe "GET new" do
    before {get :new}
    it {expect(response).to render_template :new}
    it {expect(response.status).to eq 200}
  end

  describe "POST create" do
    before do
      post :create, question: attributes_for(:question)
    end

    context "when question saves successfully" do
      it {expect(flash[:success]).to be_present}
      it {expect(response).to render_template :index}
    end

    context "when question fails to save" do
      it {expect(flash[:danger]).to be_present}
      it {expect(response).to render_template :new}
    end
  end
end
