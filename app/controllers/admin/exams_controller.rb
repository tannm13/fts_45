class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = @exams.unchecked.recent.paginate page: params[:page]
  end

  def show
    @results = @exam.results
  end

  def update
    @exam.status = :checked if params[:commit] == "Check"
    if @exam.update_attributes exam_params
      flash.now[:success] = t "flashs.finished"
      redirect_to admin_exams_path
    else
      flash.now[:danger] = t "flashs.error_finished"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit(:status, :score, results_attributes: [:id, :is_correct])
  end
end
