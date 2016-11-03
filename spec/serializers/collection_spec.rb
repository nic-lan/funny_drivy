require "./serializers/collection"

describe Serializers::Collection do
  let(:serializers) do
    [double(:serializer, as_json: :first), double(:serializer, as_json: :last)]
  end
  subject { described_class.create(opts, serializers) }

  describe ".create" do
    context "when opts key path is rentals" do
      let(:opts) { { path: :rental } }

      it "returns a rental collection" do
        expect(subject).to eq(
          rentals: [:first, :last]
        )
      end
    end

    context "when opts key path is rental_modifications" do
      let(:opts) { { path: :rental_modification } }

      it "returns a rental modification collection" do
        expect(subject).to eq(
          rental_modifications: [:first, :last]
        )
      end
    end
  end
end
