module Users
  class OmniauthCallbacksController < ApplicationController
    def facebook
      if authenticated_user.persisted?
        sign_in_and_redirect authenticated_user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook")
      else
        failure
      end
    end

    def failure
      redirect_to root_path
    end

    private

    def authenticated_user
      @authenticated_user = AuthenticateUser.call(user_params: request.env["omniauth.auth"]).user
    end
  end
end
