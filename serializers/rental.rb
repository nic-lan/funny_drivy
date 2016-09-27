require "active_model"
require "json"

module Serializers
  class Rental
    include ActiveModel::Model

    attr_accessor :rental, :price
    delegate :id, to: :rental

    def as_json
      { id: id, price: price.value }
    end
  end
end
