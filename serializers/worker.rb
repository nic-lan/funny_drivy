require "active_model"
require "./serializers/base"
require "./serializers/improved"

module Serializers
  class Worker
    include ActiveModel::Model

    attr_accessor :rental, :price, :opts

    delegate :id, to: :rental

    delegate :value,
      :insurance_fee,
      :assistance_fee,
      :drivy_fee,
      :deductible_reduction,
      :drivy,
      :owner,
      :driver,
      :opts,
      to: :price
  end
end
