require "./serializers/improved"

describe Serializers::Improved do
  subject do
    double(:worker,
      id: 1,
      driver: 1000,
      insurance_fee: 2000,
      assistance_fee: 3000,
      owner: 4000,
      drivy: 5000)
  end

  describe "#as_json" do
    before { subject.extend Serializers::Improved }

    describe "#as_json" do
      it "serializes successfully by the given entities" do
        expect(subject.as_json).to eq(
          id: 1,
          actions: [
            { who: "driver", type: "debit", amount: 1000 },
            { who: "owner", type: "credit", amount: 4000 },
            { who: "insurance", type: "credit", amount: 2000 },
            { who: "assistance", type: "credit", amount: 3000 },
            { who: "drivy", type: "credit", amount: 5000 }
          ]
        )
      end
    end
  end
end
