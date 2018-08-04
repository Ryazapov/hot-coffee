require "rails_helper"

feature "Destroy Coffee" do
  include_context :user_signed_in

  let(:coffee_house) { create :coffee_house, name: "Coffee Like", owner: current_user }

  background do
    create :coffee,
      coffee_house: coffee_house,
      name: "Cappuccino",
      kind: "hot_coffee",
      volume: 300,
      price: 4,
      description: "Classic cappuccino"

    create :coffee,
      coffee_house: coffee_house,
      name: "Latte",
      kind: "hot_coffee",
      volume: 500,
      price: 4,
      description: "Classic latte"
  end

  scenario "User destroys coffee" do
    visit manage_coffee_house_path(coffee_house)

    expect(page).to have_content("Cappuccino")

    within("tr", text: "Cappuccino") do
      click_link "delete"
    end

    expect(page).to have_content("Coffee was successfully destroyed.")
    expect(page).to have_no_content("Cappuccino")
  end
end
