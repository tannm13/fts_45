class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index

  end

  def edit
    @subjects = Subject.all
  end

  def new
    @subjects = Subject.all
    Settings.number_answers.times do
      @answer = @question.answers.build
    end
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "admin.question.seccess"
      redirect_to questions_path
    else
      flash[:warm] = t "admin.question.fail"
    end
  end

  private
  def question_params
    params.require(:question).permit :name, :question_type, :subject_id, :status,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
