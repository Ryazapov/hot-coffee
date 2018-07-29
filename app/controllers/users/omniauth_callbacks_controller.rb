module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      if authenticate_user.success?
        sign_in_and_redirect authenticate_user.user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook")
      else
        redirect_to(new_user_registration_path, alert: authenticate_user.error)
      end
    end

    private

    def authenticate_user
      @user ||= Omniauth::AuthenticateUser.call(auth_params: auth_params)
    end

    def auth_params
      request.env["omniauth.auth"]
    end
  end
end
