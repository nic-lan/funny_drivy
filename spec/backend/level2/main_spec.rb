require "./spec/spec_helper"

RSpec.describe Backend::Level2::Main do
  describe ".perform" do
    let(:data) do
      {
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 1, start_date: "2015-12-8", end_date: "2015-12-8", distance: 100 },
          { id: 2, car_id: 1, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300 },
          { id: 3, car_id: 1, start_date: "2015-07-3", end_date: "2015-07-14", distance: 1000 }
        ]
      }.to_json
    end

    let(:output) do
      {
        rentals: [
          { id: 1, price: 3000 },
          { id: 2, price: 6800 },
          { id: 3, price: 27800 }
        ]
      }.to_json
    end

    subject { described_class.perform(data) }

    it "returns the expected output" do
      expect(subject).to eq output
    end
  end
end
