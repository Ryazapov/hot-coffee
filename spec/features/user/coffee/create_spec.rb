require "rails_helper"

feature "Create Coffee" do
  include_context :user_signed_in

  let(:coffee_house) { create :coffee_house, name: "Coffee Like", owner: current_user }

  scenario "User creates coffee" do
    visit new_manage_coffee_house_coffee_path(coffee_house)

    fill_in "Name", with: "Cappuccino"
    select "Hot Coffee", from: "Type"
    fill_in "Volume", with: "300"
    fill_in "Price", with: "4"
    fill_in "Description", with: "Classic cappuccino"

    click_button "Create"

    expect(page).to have_content("Coffee was successfully created.")
  end

  scenario "User creates coffee with invalid data" do
    visit new_manage_coffee_house_coffee_path(coffee_house)

    click_button "Create"

    expect(page).to have_content("Coffee could not be created.")
  end
end
