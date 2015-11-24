class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @subjects = Subject.all
  end

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t "flashs.created"
    else
      flash.now[:danger] = t "flashs.error_created"
    end
    redirect_to :back
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id, :user_id, :status, :duration,
      :question_number
  end
end
