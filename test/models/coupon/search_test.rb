require 'test_helper'

class ModelCouponSearchTest < ActiveSupport::TestCase
  test '.search by exact' do
    promotion = Fabricate(:promotion, name: 'Natal 1', code: 'NATAL1')

    promotion.generate_coupons!

    result = Coupon.search('NATAL1-0001')
    assert_includes result.code, 'NATAL1-0001'
    assert_includes result.promotion.name, 'Natal 1'
  end

  test '.search and find nothing' do
    promotion = Fabricate(:promotion)

    promotion.generate_coupons!

    result = Coupon.search('NATAL1-0000')
    assert_nil result
  end
end
