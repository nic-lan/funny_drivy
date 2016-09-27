require "./models/price"

RSpec.describe Models::Price do
  let(:rental) do
    double :rental, start_date: "2015-12-8", end_date: end_date, distance: 100
  end
  let(:car) { double :rental, price_per_day: 1000, price_per_km: 10 }
  let(:discount) { true }

  subject do
    described_class.new(rental: rental, car: car, discount: discount).value
  end

  describe "#value" do
    let(:expected_distance_price) { 1000 }
    context "when discount set to false" do
      let(:end_date) { "2015-12-18" }
      let(:discount) { false }

      it "does not apply any discount" do
        expect(subject).to eq 11_000 + expected_distance_price
      end
    end

    context "when 1 day" do
      let(:end_date) { "2015-12-8" }

      it "does not apply any discount" do
        expect(subject).to eq 1000 + expected_distance_price
      end
    end

    context "when between 2 and 4 days" do
      let(:end_date) { "2015-12-9" }

      it "applies a discount of 10% discount" do
        expect(subject).to eq 1900 + expected_distance_price
      end
    end

    context "when between 5 and 10 " do
      let(:end_date) { "2015-12-12" }

      it "applies a discount of 30% discount" do
        expect(subject).to eq 3500 + expected_distance_price
      end
    end

    context "when more than 11" do
      let(:end_date) { "2015-12-18" }

      it "applies a discount of 50% discount" do
        expect(subject).to eq 8158 + expected_distance_price
      end
    end
  end
end
