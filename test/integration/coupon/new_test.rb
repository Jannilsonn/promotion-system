require 'test_helper'

class IntegrationCouponNewTest < ActionDispatch::IntegrationTest
  test 'cannot generate coupons without login' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de natal',
                                  code: 'NATAL10', discount_rate: 15,
                                  coupon_quantity: 5, expiration_date: '22/12/2033',
                                  user: user)

    post '/coupons', params: {
      id: promotion.id
    }

    assert_redirected_to new_user_session_path
  end
end