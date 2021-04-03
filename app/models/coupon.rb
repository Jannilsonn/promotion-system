class Coupon < ApplicationRecord
    belongs_to :promotion

    enum status: { enabled: 0, disabled: 1}

    def self.search(query)
      find_by(code: query)
    end
end
