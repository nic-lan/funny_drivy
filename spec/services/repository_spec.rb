require "./spec/spec_helper"

RSpec.describe Services::Repository do
  subject { described_class.new(input_data) }

  describe "#rentals" do
    let(:input_data) { parse_json("./spec/fixtures/repository_level_1.json") }

    it "returns the correct amount of rentals" do
      rentals = subject.rentals
      expect(rentals.count).to eq 2

      rental_first = rentals.first
      expect(rental_first.rental.id).to eq 1
      expect(rental_first.rental.car_id).to eq 1
      expect(rental_first.rental.start_date).to eq "2017-12-8"
      expect(rental_first.rental.end_date).to eq "2017-12-10"
      expect(rental_first.rental.distance).to eq 100

      expect(rental_first.car.id).to eq 1
      expect(rental_first.car.price_per_day).to eq 2000
      expect(rental_first.car.price_per_km).to eq 10

      rental_last = rentals.last
      expect(rental_last.rental.id).to eq 2
      expect(rental_last.rental.car_id).to eq 1
      expect(rental_last.rental.start_date).to eq "2017-12-14"
      expect(rental_last.rental.end_date).to eq "2017-12-18"
      expect(rental_last.rental.distance).to eq 550

      expect(rental_last.car.id).to eq 1
      expect(rental_last.car.price_per_day).to eq 2000
      expect(rental_last.car.price_per_km).to eq 10
    end
  end
end
