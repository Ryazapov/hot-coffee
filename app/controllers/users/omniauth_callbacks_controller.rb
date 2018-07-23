module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook")
    end

    private

    def user
      @user = FindOrCreateUser.call(user_params: request.env["omniauth.auth"]).user
    end
  end
end
