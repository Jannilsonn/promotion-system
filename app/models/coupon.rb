class Coupon < ApplicationRecord
    belongs_to :promotion

    enum status: { enabled: 0, disabled: 1}
end
