require "./controllers/workers_controller"

describe Controllers::WorkersController do
  let(:rental) { double :rental, id: :whatever }
  let(:price) { double :price }

  subject { described_class.create(rental: rental, price: price, opts: opts) }

  describe "#create" do
    context "when opts serializer key is :base" do
      let(:opts) { { serializer: :base } }

      it "extends the base serializer" do
        expect(subject).to be_a Serializers::Base
        expect(subject.price).to eq price
        expect(subject.rental).to eq rental
      end
    end

    context "when opts serializer key is not present" do
      let(:opts) { { serializer: :improved } }

      it "extends the base serializer" do
        expect(subject).to be_a Serializers::Improved
        expect(subject.price).to eq price
        expect(subject.rental).to eq rental
      end
    end
  end
end
