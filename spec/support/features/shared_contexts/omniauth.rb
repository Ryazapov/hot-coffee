shared_context :facebook_with_valid_credentials do
  background do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "12345",
      info: {
        email: "john.smith@example.com",
        name: "John Smith"
      },
      extra: {
        raw_info: {
          verified: true
        }
      }
    )
  end
end

shared_context :facebook_with_invalid_credentials do
  background do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end
