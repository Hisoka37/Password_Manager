class SharesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_password
    before_action :require_shareable_permissions

    def new
        @user_password = UserPassword.new
    end

    def create
        email = user_password_params[:email]&.strip&.downcase
        if email.present?
          user = User.find_by(email: email)
      
          if user
            @user_password = @password.user_passwords.new(user_id: user.id, role: user_password_params[:role])
      
            if @user_password.save
              redirect_to @password
            else
              render :new, status: :unprocessable_entity
            end
          else
            flash[:alert] = "No user found with this email: #{email}"
            render :new, status: :unprocessable_entity
          end
        else
          flash[:alert] = "Please provide a valid email"
          render :new, status: :unprocessable_entity
        end
      end
      

    def destroy
        @password.user_passwords.where(user_id: params[:id]).destroy_all 
        redirect_to @password
    end


    private

    def set_password
        @password = current_user.passwords.find(params[:password_id])
    end

    def user_password_params
        params.require(:user_password).permit(:user_id, :role, :email)
    end

    def require_shareable_permissions
        redirect_to @password unless current_user_password.shareable?
    end
end