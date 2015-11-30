class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @subjects = Subject.all
    @exams = @exams.recent.paginate page: params[:page]
  end

  def show
    @results = @exam.results
    @exam.update_status :testing if @exam.start? || @exam.saved?
    @time_remaining = @exam.time_remaining
  end

  def create
    if @exam.save
      flash[:success] = t "flashs.created"
    else
      flash.now[:danger] = t "flashs.error_created"
    end
    redirect_to :back
  end

  def update
    @exam.status = params[:commit] == "Finish" ? :unchecked : :saved
    @exam.spent_time = @exam.time_spent
    if @exam.update_attributes exam_params
      flash.now[:success] = t "flashs.finished"
      redirect_to authenticated_root_path
    else
      flash.now[:danger] = t "flashs.error_finished"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit(:subject_id, :user_id, :status, :duration,
      :question_number, :time_spent,
      results_attributes: [:id, :exam_id, :question_id, answer_content: []])
  end
end
