require "rails_helper"

feature "Show Coffee House" do
  let(:coffee_house) do
    create :coffee_house,
      :kazan_profsoyuznaya,
      name: "Coffee House",
      description: "We give very HOT COFFEE"
  end

  background do
    create :coffee, name: "Cappuccino", kind: "hot_coffee", volume: 300, price: 4, coffee_house: coffee_house
    create :coffee, name: "Frappuccino", kind: "cold_coffee", volume: 400, price: 5, coffee_house: coffee_house
    create :coffee, name: "Latte", kind: "hot_coffee", volume: 500, price: 4, coffee_house: coffee_house
    create :coffee, name: "Mocco", kind: "hot_coffee", volume: 500, price: 6, coffee_house: coffee_house
  end

  scenario "Visitor sees coffee house" do
    visit coffee_house_path(coffee_house)

    expect(page).to have_content("Coffee House")
    expect(page).to have_content("We give very HOT COFFEE")
    expect(page).to have_content("Where to find us: Profsoyuznaya Ulitsa, 50, Kazan, Russia")

    within "tbody" do
      expect(page).to have_selector("tr", count: 4)

      expect(page).to have_table_row(number: 1, values: ["Mocco", "Hot Coffee", "500 mL", "$6.00"])
      expect(page).to have_table_row(number: 2, values: ["Latte", "Hot Coffee", "500 mL", "$4.00"])
      expect(page).to have_table_row(number: 3, values: ["Frappuccino", "Cold Coffee", "400 mL", "$5.00"])
      expect(page).to have_table_row(number: 4, values: ["Cappuccino", "Hot Coffee", "300 mL", "$4.00"])
    end
  end
end
