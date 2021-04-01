require 'test_helper'

class IntegrationPromotionApproveTest < ActionDispatch::IntegrationTest
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