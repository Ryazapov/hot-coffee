require "rails_helper"

feature "Create Coffee House" do
  include_context :user_signed_in

  scenario "User creates coffee house" do
    visit new_manage_coffee_house_path

    fill_in "Name", with: "Coffee House"
    choose_location_on_map(model_name: "coffee_house", latitude: 55.78787607694294, longitude: 49.12356007675169)
    fill_in "Description", with: "We give very HOT COFFEE"

    click_button "Create"

    expect(page).to have_content("Coffee house was successfully created.")
  end

  scenario "User creates coffee house with invalid data" do
    visit new_manage_coffee_house_path

    click_button "Create"

    expect(page).to have_content("Coffee house could not be created.")
  end
end
