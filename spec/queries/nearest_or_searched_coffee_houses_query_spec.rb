require "rails_helper"
require "geocoder/results/ipinfo_io"

describe NearestOrSearchedCoffeeHousesQuery do
  subject(:query) { described_class.new(location, keywords) }

  let(:location) { instance_double(Geocoder::Result::IpinfoIo, coordinates: coordinates) }
  let(:coordinates) { [beanhearts.latitude, beanhearts.longitude] }
  let(:keywords) { "" }

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

  let!(:cappuccino) do
    create :coffee,
      name: "Cappuccino",
      coffee_house: coffee_like,
      description: "Composition of coffee: espresso, milk"
  end
  let!(:cappuccino) do
    create :coffee,
      name: "Cappuccino",
      coffee_house: beanhearts,
      description: "Composition of coffee: espresso, soy milk"
  end
  let!(:latte) do
    create :coffee,
      name: "Latte",
      coffee_house: coffee_like,
      description: "Composition of coffee: espresso, milk, cream"
  end

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to eq([beanhearts, coffee_like]) }

    context "when search with keywords" do
      context "when search by coffee house name" do
        let(:keywords) { "beanhearts" }

        it { is_expected.to eq([beanhearts]) }
      end

      context "when search by coffee house description" do
        let(:keywords) { "coffee to go" }

        it { is_expected.to eq([coffee_like]) }
      end

      context "when search by coffee name" do
        let(:keywords) { "latte" }

        it { is_expected.to eq([coffee_like]) }
      end

      context "when search by coffee description" do
        let(:keywords) { "soy milk" }

        it { is_expected.to eq([beanhearts]) }
      end
    end
  end
end
