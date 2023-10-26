class PasswordsController  < ApplicationController
    before_action :authenticate_user!

    def index
        @passwords = current_user.password   
    end

end