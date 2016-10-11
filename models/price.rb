require "active_model"

module Models
  class Price
    include ActiveModel::Model

    attr_accessor :rental, :car, :opts
    delegate :price_per_day, :price_per_km, to: :car
    delegate :day_number, :distance, to: :rental

    def initialize(rentals_with_car, opts)
      @rental = rentals_with_car[:rental]
      @car = rentals_with_car[:car]
      @opts = opts
    end

    def value
      @_value ||= time_price.to_i + distance_price
    end

    def insurance_fee
      @_insurance_fee ||= (0.5 * commission).to_i
    end

    def assistance_fee
      @_assistance_fee ||= 100 * day_number
    end

    def drivy_fee
      insurance_fee - assistance_fee
    end

    def deductible_reduction
      @_deductible_reduction ||= begin
        rental.deductible_reduction ? 400 * day_number : 0
      end
    end

    private

    def commission
      value * 0.30
    end

    def time_price
      apply_discount * day_number * price_per_day
    end

    def distance_price
      distance * price_per_km
    end

    def apply_discount
      return 1 unless opts[:discount]
      no_discount || small || medium || large
    end

    def no_discount
      1 if day_number == 1
    end

    def small
      0.95 if (2..3).cover?(day_number)
    end

    def medium
      0.70 if (4..9).cover?(day_number)
    end

    def large
      0.7417 if day_number >= 10
    end
  end
end
