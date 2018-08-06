require "rails_helper"

feature "Index Coffee House" do
  let!(:coffee_like) do
    create :coffee_house,
      :kazan_butlerova,
      name: "Coffee Like",
      description: "Сoffee to go"
  end
  let!(:beanhearts) do
    create :coffee_house,
      :kazan_profsoyuznaya,
      name: "Beanhearts",
      description: "The best place to spend an evening with friends"
  end

  scenario "Visitor sees list of coffee houses" do
    visit coffee_houses_path

    within "tbody" do
      expect(page).to have_selector("tr", count: 2)

      expect(page).to have_table_row(number: 1, values: ["Beanhearts", "Profsoyuznaya Ulitsa, 50, Kazan, Russia"])
      expect(page).to have_table_row(number: 2, values: ["Coffee Like", "Ulitsa Butlerova, 4, Kazan, Russia"])
    end
  end

  scenario "Visitor search coffee house" do
    visit coffee_houses_path

    fill_in "Search", with: "Bean"
    click_button "Search"

    within "tbody" do
      expect(page).to have_selector("tr", count: 1)

      expect(page).to have_table_row(number: 1, values: ["Beanhearts", "Profsoyuznaya Ulitsa, 50, Kazan, Russia"])
    end
  end
end
