require "rails_helper"

feature "Show Coffee" do
  let(:coffee_house) { create :coffee_house, name: "Coffee Like" }
  let(:coffee) do
    create :coffee,
      coffee_house: coffee_house,
      name: "Cappuccino",
      kind: "hot_coffee",
      volume: 300,
      price: 4,
      description: "Classic cappuccino"
  end

  scenario "Visitor sees coffee" do
    visit coffee_path(coffee)

    expect(page).to have_link("Coffee Like")
    expect(page).to have_content("Coffee House: Coffee Like")
    expect(page).to have_content("Type: Hot Coffee")
    expect(page).to have_content("Volume: 300 mL")
    expect(page).to have_content("Price: $4.00")
    expect(page).to have_content("Classic cappuccino")
  end
end
