require "rails_helper"

feature "Show Coffee House" do
  include_context :user_signed_in

  let(:coffee_house) do
    create :coffee_house,
      owner: current_user,
      name: "Coffee House",
      description: "We give very HOT COFFEE",
      latitude: 55.78778545536969,
      longitude: 49.122609570622444,
      address: "Profsoyuznaya Ulitsa, 50, Kazan, Russia"
  end

  scenario "User sees coffee house" do
    visit manage_coffee_house_path(coffee_house)

    expect(page).to have_content("Coffee House")
    expect(page).to have_content("We give very HOT COFFEE")
    expect(page).to have_content("Where to find us: Profsoyuznaya Ulitsa, 50, Kazan, Russia")
    expect(page).to have_link("Add Coffee")
  end
end
