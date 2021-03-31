require 'test_helper'

class PromotionFlowTest < ActionDispatch::IntegrationTest
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

  test 'approve if user is different from owner' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Cyber Monday',
                                  coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15',
                                  discount_rate: 15,
                                  expiration_date: '22/12/2033',
                                  user: user)
    
    approver = login_user
    post approve_promotion_path(promotion)
    assert_redirected_to promotion_path(promotion)

    assert promotion.reload.approved?
    assert_equal 'Promoção aprovada com sucesso', flash[:notice]
  end

  test 'cannot approve if owner' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Cyber Monday',
                                  coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15',
                                  discount_rate: 15,
                                  expiration_date: '22/12/2033',
                                  user: user)
    login_user(user)
    post approve_promotion_path(promotion)
    assert_redirected_to promotion_path(promotion)

    refute promotion.reload.approved?
    assert_equal 'Ação não permitida', flash[:alert]
  end
end