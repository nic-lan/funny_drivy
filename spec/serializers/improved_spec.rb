require "./serializers/improved"

describe Serializers::Improved do
  let(:price_value) { 3000 }
  let(:insurance_fee) { 450 }
  let(:assistance_fee) { 100 }
  let(:drivy_fee) { 350 }
  let(:deductible_reduction) { 400 }

  subject do
    double(:worker,
      id: 1,
      value: price_value,
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee,
      deductible_reduction: deductible_reduction)
  end

  describe "#as_json" do
    before { subject.extend Serializers::Improved }

    describe "#as_json" do
      let(:driver) { price_value + deductible_reduction }
      let(:owner) { price_value - (insurance_fee + drivy_fee + assistance_fee) }
      let(:drivy) { drivy_fee + deductible_reduction }
      it "serializes successfully by the given entities" do
        expect(subject.as_json).to eq(
          id: 1,
          actions: [
            { who: "driver", type: "debit", amount: driver },
            { who: "owner", type: "credit", amount: owner },
            { who: "insurance", type: "credit", amount: insurance_fee },
            { who: "assistance", type: "credit", amount: assistance_fee },
            { who: "drivy", type: "credit", amount: drivy }
          ]
        )
      end
    end
  end
end
