require "./models/rental"

RSpec.describe Models::Rental do
  let(:attributes) do
    {
      "id" => 1,
      "car_id" => 1,
      "start_date" => "2017-12-8",
      "end_date" => end_date,
      "distance" => 100
    }
  end

  let(:end_date) { "2017-12-10" }
  subject { described_class.new(attributes) }

  describe ".new" do
    it "instantiates correctly from attributes hash" do
      expect(subject.id).to eq 1
      expect(subject.car_id).to eq 1
      expect(subject.start_date).to eq "2017-12-8"
      expect(subject.end_date).to eq "2017-12-10"
      expect(subject.distance).to eq 100
      expect(subject.distance).to eq 100
      expect(subject.deductible_reduction).to be_falsey
    end

    context "when a deductible_reduction is given" do
      before { attributes.merge!(deductible_reduction: true) }

      it "sets the deductible_reduction" do
        expect(subject.deductible_reduction).to be_truthy
      end
    end
  end

  describe "day_number" do
    context "when end_date is equal to start_date" do
      let(:end_date) { "2017-12-8" }

      it "returns 1" do
        expect(subject.day_number).to eq 1
      end
    end

    context "when end_date is more than one day" do
      let(:end_date) { "2017-12-9" }

      it "returns the the number of day between start_date and end_date" do
        expect(subject.day_number).to eq 2
      end
    end
  end
end
