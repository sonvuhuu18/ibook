class UsersController < ApplicationController
  before_action :check_role, only: :index

  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to(users_path, notice: "Role updated")
    else
      redirect_to(user_path, alert: "Failed")
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def check_role
    redirect_to(root_path, alert: "Unauthorized access") if current_user.regular_user?
  end
end
