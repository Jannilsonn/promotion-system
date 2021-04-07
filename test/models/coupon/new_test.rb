require "test_helper"

class ModelCouponNewTest < ActiveSupport::TestCase
  test 'generate_coupons! successfully' do
    promotion = Fabricate(:promotion)
    
    promotion.generate_coupons!
    assert_equal promotion.coupons.size, promotion.coupon_quantity
    assert_equal promotion.coupons.first.code, 'NATAL0-0001'
  end

  test 'generate_coupons! connot be called twice' do
    promotion = Fabricate(:promotion)
    
    Coupon.create!(code: 'NATAL0', promotion: promotion)

    assert_no_difference 'Coupon.count' do
      promotion.generate_coupons!
    end
  end
end