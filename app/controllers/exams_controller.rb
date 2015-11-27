class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @subjects = Subject.all
    @exams = @exams.paginate page: params[:page]
  end

  def show
    @results = @exam.results
    @exam.update_status :testing if @exam.start?
    @time_remaining = @exam.time_remaining
    @is_time_over = @time_remaining < Settings.exam.time_out
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
    if @exam.update_attributes exam_params
      flash[:success] = t "flashs.finished"
      redirect_to authenticated_root_path
    else
      flash.now[:danger] = t "flashs.error_finished"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit(:subject_id, :user_id, :status, :duration,
      :question_number,
      results_attributes: [:id, :exam_id, :question_id, answer_content: []])
  end
end
