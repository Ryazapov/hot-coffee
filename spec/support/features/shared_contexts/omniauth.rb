shared_context :facebook_with_valid_credentials do
  background do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "12345",
      info: {
        email: "john.smith@example.com",
        name: "John Smith"
      }
    )
  end
end

shared_context :facebook_with_invalid_credentials do
  background do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end

shared_context :google_with_valid_credentials do
  background do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid: "12345",
      info: {
        email: "john.smith@gmail.com",
        name: "John Smith"
      }
    )
  end
end

shared_context :google_with_invalid_credentials do
  background do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end
