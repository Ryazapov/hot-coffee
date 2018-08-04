require "rails_helper"

feature "Sign In" do
  let(:user) { create :user }
  let(:unconfirmed_user) { create :user, :not_confirmed }

  scenario "Visitor signs in with valid credentials" do
    visit new_user_session_path

    fill_form(:user, email: user.email, password: user.password)
    click_button "Sign in"

    expect(page).to have_content("Signed in successfully.")
  end

  scenario "Visitor signs in with invalid credentials" do
    visit new_user_session_path

    fill_form(:user, email: user.email, password: "wrong password")
    click_button "Sign in"

    expect(page).to have_content("Sign in")
    expect(page).to have_content("Invalid Email or password")
  end

  scenario "Visitor signs in with unconfirmed email address" do
    visit new_user_session_path

    fill_form(:user, email: unconfirmed_user.email, password: unconfirmed_user.password)
    click_button "Sign in"

    expect(page).to have_content("You have to confirm your email address before continuing.")
  end

  context "when visitor has facebook account" do
    include_context :facebook_with_valid_credentials

    scenario "Visitor signs in with facebook" do
      visit new_user_session_path

      click_link "Sign in with Facebook"

      expect(page).to have_content("Successfully authenticated from Facebook account.")
    end

    context "when credentials is invalid" do
      include_context :facebook_with_invalid_credentials

      scenario "Visitor cannot signs in with facebook" do
        visit new_user_session_path

        click_link "Sign in with Facebook"

        expect(page).to have_content("Could not authenticate you from Facebook because \"Invalid credentials\".")
      end
    end
  end

  context "when visitor has google account", :js do
    include_context :google_with_valid_credentials

    scenario "Visitor signs in with google" do
      visit new_user_session_path

      click_link "Sign in with Google Oauth2"

      expect(page).to have_content("Successfully authenticated from Google account.")
    end

    context "when credentials is invalid" do
      include_context :google_with_invalid_credentials

      scenario "Visitor cannot signs in with google" do
        visit new_user_session_path

        click_link "Sign in with Google Oauth2"

        expect(page).to have_content("Could not authenticate you from GoogleOauth2 because \"Invalid credentials\".")
      end
    end
  end
end
