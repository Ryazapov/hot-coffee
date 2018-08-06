require "rails_helper"
require "geocoder/results/ipinfo_io"

describe NearestCoffeeHousesQuery do
  subject(:query) { described_class.new(location) }

  let(:location) { instance_double(Geocoder::Result::IpinfoIo, coordinates: coordinates) }
  let(:coordinates) { [kazan_butlerova_coffee_house.latitude, kazan_butlerova_coffee_house.longitude] }

  let!(:kazan_butlerova_coffee_house) { create :coffee_house, :kazan_butlerova }
  let!(:kazan_profsoyuznaya_coffee_house) { create :coffee_house, :kazan_profsoyuznaya }
  let!(:moscow_coffee_house) { create :coffee_house, :moscow_red_square }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to eq([kazan_butlerova_coffee_house, kazan_profsoyuznaya_coffee_house]) }

    context "when coordinates are 10 kilometers from profsoyuznaya" do
      let(:coordinates) { [55.866795, 49.046769] }

      it { is_expected.to eq([kazan_profsoyuznaya_coffee_house]) }
    end

    context "when coordinates of Moscow" do
      let(:coordinates) { [55.751244, 37.618423] }

      it { is_expected.to eq([moscow_coffee_house]) }
    end
  end
end
