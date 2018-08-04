require "rails_helper"

feature "Index Coffee" do
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

  scenario "User sees list of coffee houses" do
    visit manage_coffee_house_path(coffee_house)

    within "tbody" do
      expect(page).to have_selector("tr", count: 2)

      expect_page_to_have_row(
        number: 1,
        values: ["Cappuccino", "Hot Coffee", "300 mL", "$4.00", "edit", "delete"]
      )
      expect_page_to_have_row(
        number: 2,
        values: ["Latte", "Hot Coffee", "500 mL", "$4.00", "edit", "delete"]
      )
    end
  end

  def expect_page_to_have_row(number:, values:)
    within "tr:nth-child(#{number})" do
      expect(page.all("td").map(&:text)).to eq(values)
    end
  end
end
