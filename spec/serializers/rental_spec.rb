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

  let(:price) do
    double(
      :price,
      value: 5000,
      insurance_fee: 4170,
      assistance_fee: 1200,
      drivy_fee: 2970
    )
  end

  subject { described_class.new(rental: rental, price: price, opts: opts) }

  describe "#as_json" do
    context "when opts is false" do
      let(:opts) { { commission: false } }

      let(:expected) do
        {
          id: 1,
          price: 5000
        }
      end

      it "serializes successfully by the given entities" do
        expect(subject.as_json).to eq expected
      end
    end

    context "when opts commission true" do
      let(:opts) { { commission: true } }

      let(:expected) do
        {
          id: 1,
          price: 5000,
          commission: {
            insurance_fee: 4170,
            assistance_fee: 1200,
            drivy_fee: 2970
          }
        }
      end

      it "serializes successfully by the given entities" do
        expect(subject.as_json).to eq expected
      end
    end
  end
end
