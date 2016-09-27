require "active_model"

module Models
  class Price
    include ActiveModel::Model

    attr_accessor :rental, :car, :discount
    delegate :price_per_day, :price_per_km, to: :car
    delegate :start_date, :end_date, :distance, to: :rental
    delegate :parse, to: Date

    def value
      time_price.to_i + distance_price
    end

    private

    def time_price
      apply_discount * day_number * price_per_day
    end

    def distance_price
      distance * price_per_km
    end

    def day_number
      @_day_number ||= (parse(end_date) - parse(start_date) + 1).to_i
    end

    def apply_discount
      return 1 unless discount
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
