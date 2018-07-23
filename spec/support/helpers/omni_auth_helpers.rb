module OmniAuthHelpers
  def facebook_with_valid_credentials
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "123545",
      info: {
        email: "john.smith@example.com",
        name: "John Smith"
      }
    )
  end

  def facebook_with_invalid_credentials
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end
