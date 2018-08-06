require "rails_helper"

feature "Update Coffee" do
  include_context :user_signed_in

  let(:coffee_house) { create :coffee_house, name: "Coffee Like", owner: current_user }
  let(:coffee) { create :coffee, coffee_house: coffee_house }

  scenario "User updates coffee" do
    visit edit_manage_coffee_house_coffee_path(coffee_house, coffee)

    fill_in "Name", with: "Cappuccino"
    select "Hot Coffee", from: "Type"
    fill_in "Volume", with: "300"
    fill_in "Price", with: "4"
    fill_in "Description", with: "Classic cappuccino"

    click_button "Update"

    expect(page).to have_content("Coffee was successfully updated.")
  end

  scenario "User updates coffee with invalid data" do
    visit edit_manage_coffee_house_coffee_path(coffee_house, coffee)

    fill_in "Name", with: ""

    click_button "Update"

    expect(page).to have_content("Coffee could not be updated.")
  end
end
