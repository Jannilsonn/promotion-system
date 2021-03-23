class Coupon < ApplicationRecord
    belongs_to :promotion

    enum status: { active: 0, disabled: 1}
end
