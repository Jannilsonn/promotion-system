require 'test_helper'

class IntegrationCouponNewTest < ActionDispatch::IntegrationTest
  test 'cannot generate coupons without login' do
    promotion = Fabricate(:promotion)

    post '/coupons', params: {
      id: promotion.id
    }

    assert_redirected_to new_user_session_path
  end
end
