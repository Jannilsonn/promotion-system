require 'test_helper'

class IntegrationCouponDestroyTest < ActionDispatch::IntegrationTest
  test 'cannot destroy coupons without login' do
    promotion = Fabricate(:promotion)

    delete promotion_path(promotion)

    assert_redirected_to new_user_session_path
  end
end
