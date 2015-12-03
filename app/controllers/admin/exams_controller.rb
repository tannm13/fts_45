class Admin::ExamsController < Admin::BaseController
  load_resource
  before_action :load_activities, only: :index

  def index
    @search = @exams.ransack params[:q]
    @search.sorts = Settings.exam.sort_by_date if @search.sorts.empty?
    @exams = @search.result.paginate page: params[:page],
      per_page: Settings.exam.per_page
  end

  def show
    @results = @exam.results
  end

  def update
    @exam.status = :checked if params[:commit] == "Check"
    if @exam.update_attributes exam_params
      @exam.create_activity :check
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

  def load_activities
    @activities = PublicActivity::Activity.order(created_at: :desc)
  end
end
