class UsersController < ApplicationController
    before_action :check_role, only: :index
    
    def index
       @users = User.all
    end
    
    def show
       @user = User.find(params[:id])
    end
    
    private
    
    def check_role
      redirect_to(root_path, alert: "Unauthorized access") if current_user.role != "superadmin"
    end

end
