require "rails_helper"

feature "Index Coffee House" do
  include_context :user_signed_in

  background do
    create :coffee_house,
      :kazan_butlerova,
      owner: current_user,
      name: "Sweety Coffee"

    create :coffee_house,
      :kazan_profsoyuznaya,
      owner: current_user,
      name: "Coffee House"
  end

  scenario "User sees list of coffee houses" do
    visit manage_coffee_houses_path

    within "tbody" do
      expect(page).to have_selector("tr", count: 2)

      expect(page).to have_table_row(
        number: 1,
        values: ["Coffee House", "Profsoyuznaya Ulitsa, 50, Kazan, Russia", "edit", "delete"]
      )
      expect(page).to have_table_row(
        number: 2,
        values: ["Sweety Coffee", "Ulitsa Butlerova, 4, Kazan, Russia", "edit", "delete"]
      )
    end
  end
end
