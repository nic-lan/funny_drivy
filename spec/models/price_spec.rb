require "./models/price"

RSpec.describe Models::Price do
  let(:rental) do
    double :rental, day_number: day_number, distance: 100
  end
  let(:day_number) { 1 }
  let(:car) { double :car, price_per_day: 1000, price_per_km: 10 }
  let(:rentals_with_car) { { rental: rental, car: car } }
  let(:discount) { true }
  let(:opts) { { discount: discount } }

  subject { described_class.new(rentals_with_car, opts) }

  describe "#insurance_fee, assistance_fee, drivy_fee" do
    let(:day_number) { 1 }

    before { allow(subject).to receive(:value).and_return(1000) }

    it "half of 30% price goes to to the insurance" do
      expect(subject.insurance_fee).to eq 150
    end

    it "1 euro / day goes to the assistance fee" do
      expect(subject.assistance_fee).to eq(100)
    end

    it "the rest 30% goes to drivy" do
      expect(subject.drivy_fee).to eq(50)
    end
  end

  describe "#value" do
    let(:expected_distance_price) { 1000 }
    context "when discount set to false" do
      let(:day_number) { 11 }
      let(:discount) { false }

      it "does not apply any discount" do
        expect(subject.value).to eq 11_000 + expected_distance_price
      end
    end

    context "when 1 day" do
      let(:day_number) { 1 }

      it "does not apply any discount" do
        expect(subject.value).to eq 1000 + expected_distance_price
      end
    end

    context "when between 2 and 4 days" do
      let(:day_number) { 2 }

      it "applies a discount of 5% discount" do
        expect(subject.value).to eq 1900 + expected_distance_price
      end
    end

    context "when between 5 and 10 " do
      let(:day_number) { 5 }

      it "applies a discount of 30% discount" do
        expect(subject.value).to eq 3500 + expected_distance_price
      end
    end

    context "when more than 11" do
      let(:day_number) { 11 }

      it "applies a discount of 25,83% discount" do
        expect(subject.value).to eq 8158 + expected_distance_price
      end
    end
  end

  describe "deductible_reduction" do
    context "when given rental chooses for a deductible_reduction" do
      let(:rental) do
        double :rental, day_number: 1, deductible_reduction: true, distance: 100
      end

      it "returns the correct value for the deductible reduction" do
        expect(subject.deductible_reduction).to eq 400
      end
    end

    context "when given rental chooses for a deductible_reduction" do
      let(:rental) do
        double :rental,
          day_number: 1,
          deductible_reduction: false,
          distance: 100
      end

      it "returns the correct value for the deductible reduction" do
        expect(subject.deductible_reduction).to eq(0)
      end
    end
  end

  describe "#driver" do
    before do
      allow(subject).to receive(:value).and_return(1)
      allow(subject).to receive(:deductible_reduction).and_return(1)
    end

    it "returns the correct driver value" do
      expect(subject.driver).to eq 2
    end
  end

  describe "#drivy" do
    before do
      allow(subject).to receive(:drivy_fee).and_return(1)
      allow(subject).to receive(:deductible_reduction).and_return(1)
    end

    it "returns the correct driver value" do
      expect(subject.drivy).to eq 2
    end
  end

  describe "#owner" do
    before do
      allow(subject).to receive(:value).and_return(3)
      allow(subject).to receive(:drivy_fee).and_return(1)
      allow(subject).to receive(:insurance_fee).and_return(1)
      allow(subject).to receive(:assistance_fee).and_return(1)
    end

    it "returns the correct driver value" do
      expect(subject.owner).to eq 0
    end
  end
end
