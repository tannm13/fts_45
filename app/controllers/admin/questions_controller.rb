class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
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
      flash[:seccess] = t "admin.question.seccess"
      redirect_to admin_questions_path
    else
      flash[:seccess] = t "admin.question.fail"
      redirect_to :back
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "admin.question.seccess"
      redirect_to admin_questions_path
    else
      flash[:seccess] = t "admin.question.fail"
      rend :edit
    end
  end

  def destroy
  end

  private
  def question_params
    params.require(:question).permit :name, :subject_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
