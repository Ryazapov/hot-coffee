require "rails_helper"

feature "Destroy Coffee House" do
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
