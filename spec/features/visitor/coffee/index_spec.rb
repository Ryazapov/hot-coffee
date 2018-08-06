require "rails_helper"

feature "Index Coffee" do
  background do
    create :coffee, name: "Cappuccino", kind: "hot_coffee", volume: 300, price: 4
    create :coffee, name: "Frappuccino", kind: "cold_coffee", volume: 400, price: 5
    create :coffee, name: "Latte", kind: "hot_coffee", volume: 500, price: 4
    create :coffee, name: "Mocco", kind: "hot_coffee", volume: 500, price: 6
  end

  scenario "Visitor sees list of coffee" do
    visit coffees_path

    within "tbody" do
      expect(page).to have_selector("tr", count: 4)

      expect(page).to have_table_row(number: 1, values: ["Mocco", "Hot Coffee", "500 mL", "$6.00"])
      expect(page).to have_table_row(number: 2, values: ["Latte", "Hot Coffee", "500 mL", "$4.00"])
      expect(page).to have_table_row(number: 3, values: ["Frappuccino", "Cold Coffee", "400 mL", "$5.00"])
      expect(page).to have_table_row(number: 4, values: ["Cappuccino", "Hot Coffee", "300 mL", "$4.00"])
    end
  end

  scenario "Visitor filter coffee" do
    visit coffees_path

    select "Hot Coffee", from: "Type"
    fill_in "Volume from", with: "300"
    fill_in "Volume to", with: "600"
    fill_in "Price from", with: "4"
    fill_in "Price to", with: "5"

    click_button "Search"

    within "tbody" do
      expect(page).to have_selector("tr", count: 2)

      expect(page).to have_table_row(number: 1, values: ["Latte", "Hot Coffee", "500 mL", "$4.00"])
      expect(page).to have_table_row(number: 2, values: ["Cappuccino", "Hot Coffee", "300 mL", "$4.00"])
    end
  end
end
