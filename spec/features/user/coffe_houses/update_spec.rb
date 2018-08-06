require "rails_helper"

feature "Update Coffee House" do
  include_context :user_signed_in

  let(:coffee_house) { create :coffee_house, owner: current_user }

  scenario "User updates coffee house" do
    visit edit_manage_coffee_house_path(coffee_house)

    fill_in "Name", with: "Coffee House"
    choose_location_on_map(model_name: "coffee_house", latitude: 55.78778545536969, longitude: 49.122609570622444)
    fill_in "Description", with: "We give very HOT COFFEE"

    click_button "Update"

    expect(page).to have_content("Coffee house was successfully updated.")
  end

  scenario "User updates coffee house with invalid data" do
    visit edit_manage_coffee_house_path(coffee_house)

    fill_in "Name", with: ""

    click_button "Update"

    expect(page).to have_content("Coffee house could not be updated.")
  end
end
