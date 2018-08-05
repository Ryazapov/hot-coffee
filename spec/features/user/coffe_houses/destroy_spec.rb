require "rails_helper"

feature "Destroy Coffee House" do
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

  scenario "User destroys coffee house" do
    visit manage_coffee_houses_path

    expect(page).to have_content("Sweety Coffee")

    within("tr", text: "Sweety Coffee") do
      click_link "delete"
    end

    expect(page).to have_content("Coffee house was successfully destroyed.")
    expect(page).to have_no_content("Sweety Coffee")
  end
end
