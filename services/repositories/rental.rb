require "active_support/core_ext/module/delegation"
require "./models/rental"
require "./models/car"
require_relative "helpers"

module Services
  module Repositories
    class Rental
      include ::Services::Repositories::Helpers

      def all
        data[:rentals].map do |rental_params|
          rental = ::Models::Rental.new(rental_params)
          car = car_by_rental(rental)

          OpenStruct.new(rental: rental, car: car)
        end
      end

      private

      def car_by_rental(rental)
        car_params = car_params_by_rental(rental)
        OpenStruct.new(car_params) if car_params.present?
      end

      def car_params_by_rental(rental)
        data[:cars].bsearch { |car_params| car_params[:id] >= rental.car_id }
      end
    end
  end
end
