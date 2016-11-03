require "./spec/spec_helper"

describe Services::Repositories::RentalModification do
  let(:data) { parse_json("./spec/fixtures/repository_level_6.json") }
  let(:rental_first) { double :resource, rental: double(:rental, id: ) }
  let(:rentals) { [ ] }

  subject { described_class.new(data, rentals) }

  describe "#all" do
    it "returns all the rental_modifcation resources" do
      expect(subject.all).to eq
    end
  end
end
