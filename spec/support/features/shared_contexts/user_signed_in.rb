shared_context :user_signed_in do
  let(:current_user) { create :user }

  background do
    login_as current_user
  end
end
