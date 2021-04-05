class Coupon < ApplicationRecord
    belongs_to :promotion

    enum status: { enabled: 0, disabled: 1}

    delegate :discount_rate, to: :promotion

    def self.search(query)
      find_by(code: query)
    end

    def as_json(options = {})
      super({ methods: :discount_rate }.merge(options))
    end
end
