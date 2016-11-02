module Serializers
  module Improved
    def as_json
      {
        id: id,
        actions: [
          { who: "driver", type: "debit", amount: driver },
          { who: "owner", type: "credit", amount: owner },
          { who: "insurance", type: "credit", amount: insurance_fee },
          { who: "assistance", type: "credit", amount: assistance_fee },
          { who: "drivy", type: "credit", amount: drivy }
        ]
      }
    end
  end
end
