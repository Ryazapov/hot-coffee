require "rails_helper"
require "geocoder/results/ipinfo_io"

describe NearestCoffeeHousesQuery do
  subject(:query) { described_class.new(relation, location) }
  let(:relation) { CoffeeHouse.all }

  let(:location) { instance_double(Geocoder::Result::IpinfoIo, coordinates: kazan_coordinates) }
  let(:kazan_coordinates) { [55.788258, 49.119290] }

  let!(:coffee_house_within_radius) { create :coffee_house, :kazan_butlerova }
  let!(:coffee_house_beyond_radius) { create :coffee_house, :moscow_red_square }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to eq([coffee_house_within_radius]) }
  end
end
