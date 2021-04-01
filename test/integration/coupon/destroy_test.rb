require 'test_helper'

class IntegrationCouponDestroyTest < ActionDispatch::IntegrationTest
  test  'cannot destroy coupons without login' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de natal',
                                  code: 'NATAL10', discount_rate: 15,
                                  coupon_quantity: 5, expiration_date: '22/12/2033',
                                  user: user)
    
    delete promotion_path(promotion)

    assert_redirected_to new_user_session_path
  end
end