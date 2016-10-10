require "active_model"

module Models
  class Rental
    include ::ActiveModel::Model

    attr_accessor :id,
      :car_id,
      :start_date,
      :end_date,
      :distance,
      :deductible_reduction

    delegate :parse, to: Date

    def day_number
      @_day_number ||= (parse(end_date) - parse(start_date) + 1).to_i
    end
  end
end
