require 'test_helper'

class IntegrationPromotionNewTest < ActionDispatch::IntegrationTest
  test 'can create a promotion' do
    user = login_user
    post '/promotions', params: { 
      promotion: {
        name: 'Natal',
        description: 'Promoção de natal',
        code: 'NATAL10',
        discount_rate: 15,
        coupon_quantity: 5, 
        expiration_date: '22/12/2033',
        user: user
      }
    }

    assert_redirected_to promotion_path(Promotion.last)
    follow_redirect!
    assert_select 'h3', 'Natal'
  end

  test 'cannot create a promotion without login' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')
    post '/promotions', params: { 
      promotion: {
        name: 'Natal',
        description: 'Promoção de natal',
        code: 'NATAL10',
        discount_rate: 15,
        coupon_quantity: 5, 
        expiration_date: '22/12/2033',
        user: user
      }
    }

    assert_redirected_to new_user_session_path
  end
end