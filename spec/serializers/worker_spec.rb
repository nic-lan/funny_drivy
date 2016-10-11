require "./serializers/worker"

describe Serializers::Worker do
  let(:rental) { double :rental, id: :whatever }
  let(:price) do
    double :price,
      value: :whatever,
      insurance_fee: :whatever,
      assistance_fee: :whatever,
      drivy_fee: :whatever,
      deductible_reduction: :whatever,
      opts: opts
  end

  subject { described_class.setup(rental: rental, price: price, opts: opts) }

  describe "#setup" do
    let(:worker) { double :worker }
    before { allow(described_class).to receive(:new).and_return(worker) }

    context "when opts serializer key is not present" do
      let(:opts) { {} }
      it "extends the base serializer" do
        expect(worker).to receive(:extend).with(Serializers::Base)
        expect(subject).to eq worker
      end
    end

    context "when opts serializer key is :base" do
      let(:opts) { { serializer: :base } }
      it "extends the base serializer" do
        expect(worker).to receive(:extend).with(Serializers::Base)
        expect(subject).to eq worker
      end
    end
    context "when opts serializer key is not present" do
      let(:opts) { { serializer: :improved } }

      it "extends the base serializer" do
        expect(worker).to receive(:extend).with(Serializers::Improved)
        expect(subject).to eq worker
      end
    end
  end
end
