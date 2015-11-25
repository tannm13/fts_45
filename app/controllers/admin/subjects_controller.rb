class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = @subjects.paginate page: params[:page]
  end

  def new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "admin.subject.success"
      redirect_to admin_subjects_path
    else
      flash[:warm] = t "admin.subject.fail"
      render :new
    end
  end

  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash[:success] = t "update"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = t "deletesuccess"
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name
  end
end
