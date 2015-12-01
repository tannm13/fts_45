class Admin::UsersController < Admin::BaseController
  load_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "admin.question.seccess"
      redirect_to admin_users_path
    else
      flash[:warm] = t "admin.question.fail"
      redirect_to :back
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.question.seccess"
      redirect_to admin_users_path
    else
      flash[:seccess] = t "admin.question.fail"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end

end
