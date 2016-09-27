require "./serializers/rental"

RSpec.describe Serializers::Rental do
  let(:rental) do
    double(
      :rental,
      id: 1,
      start_date: "2017-12-8",
      end_date: "2017-12-10",
      distance: 100
    )
  end
  let(:price) { double(:price, value: 5000) }

  subject { described_class.new(rental: rental, price: price) }

  describe "#as_json" do
    let(:expected) { { id: 1, price: 5000 } }

    it "serializes successfully by the given entities" do
      expect(subject.as_json).to eq expected
    end
  end
end
