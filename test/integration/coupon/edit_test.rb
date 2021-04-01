require 'test_helper'

class IntegrationCouponEditTest < ActionDispatch::IntegrationTest
  test 'cannot update coupons without login' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de natal',
                                  code: 'NATAL10', discount_rate: 15,
                                  coupon_quantity: 5, expiration_date: '22/12/2033',
                                  user: user)

    promotion_update = {
      id: promotion.id,
      promotion: {
        name: 'Cyber Monday',
        description: 'Promoção de Cyber Monday',
        code: 'CYBER15',
        discount_rate: 15,
        coupon_quantity: 5, 
        expiration_date: '22/12/2033'
      }
    }
    put promotion_path(promotion_update)

    assert_redirected_to new_user_session_path
  end
end