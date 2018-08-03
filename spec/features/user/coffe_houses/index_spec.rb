require "rails_helper"

feature "Index Coffee House" do
  include_context :user_signed_in

  background do
    create :coffee_house,
      owner: current_user,
      name: "Sweety Coffee",
      latitude: 55.78787607694294,
      longitude: 49.12356007675169,
      address: "Ulitsa Butlerova, 4, Kazan, Russia"

    create :coffee_house,
      owner: current_user,
      name: "Coffee House",
      latitude: 55.78778545536969,
      longitude: 49.122609570622444,
      address: "Profsoyuznaya Ulitsa, 50, Kazan, Russia"
  end

  scenario "User sees list of coffee houses" do
    visit manage_coffee_houses_path

    within "tbody" do
      expect(page).to have_selector("tr", count: 2)

      expect_page_to_have_row(
        number: 1,
        values: ["Coffee House", "Profsoyuznaya Ulitsa, 50, Kazan, Russia", "edit", "delete"]
      )
      expect_page_to_have_row(
        number: 2,
        values: ["Sweety Coffee", "Ulitsa Butlerova, 4, Kazan, Russia", "edit", "delete"]
      )
    end
  end

  def expect_page_to_have_row(number:, values:)
    within "tr:nth-child(#{number})" do
      expect(page.all("td").map(&:text)).to eq(values)
    end
  end
end
