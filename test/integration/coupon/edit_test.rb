require 'test_helper'

class IntegrationCouponEditTest < ActionDispatch::IntegrationTest
  test 'cannot update coupons without login' do
    promotion = Fabricate(:promotion)

    put promotion_path(id: promotion.id,
                      promotion: Fabricate.attributes_for(:promotion))

    assert_redirected_to new_user_session_path
  end
end