require "rails_helper"

describe FilterCoffeesQuery do
  subject(:query) { described_class.new(filter_params) }

  let!(:cappuccino) { create :coffee, kind: "hot_coffee", volume: 300, price: 4 }
  let!(:frappuccino) { create :coffee, kind: "cold_coffee", volume: 400, price: 5 }
  let!(:latte) { create :coffee, kind: "hot_coffee", volume: 500, price: 4 }
  let!(:mocco) { create :coffee, kind: "hot_coffee", volume: 500, price: 6 }

  let(:filter_params) { nil }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to eq([mocco, latte, frappuccino, cappuccino]) }

    context "when filter by kind" do
      let(:filter_params) do
        {
          kind: "hot_coffee"
        }
      end

      it { is_expected.to eq([mocco, latte, cappuccino]) }
    end

    context "when filter by volume" do
      let(:filter_params) do
        {
          volume_from: 250,
          volume_to: 450
        }
      end

      it { is_expected.to eq([frappuccino, cappuccino]) }
    end

    context "when filter by price" do
      let(:filter_params) do
        {
          price_from: 4.5,
          price_to: 10
        }
      end

      it { is_expected.to eq([mocco, frappuccino]) }
    end

    context "when full filter" do
      let(:filter_params) do
        {
          kind: "hot_coffee",
          volume_from: 350,
          volume_to: 550,
          price_from: 4.5,
          price_to: 10
        }
      end

      it { is_expected.to eq([mocco]) }
    end
  end
end
