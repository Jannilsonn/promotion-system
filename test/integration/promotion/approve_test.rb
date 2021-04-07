require 'test_helper'

class IntegrationPromotionApproveTest < ActionDispatch::IntegrationTest
  test 'approve if user is different from owner' do
    promotion = Fabricate(:promotion)
    
    approver = login_user
    post approve_promotion_path(promotion)
    assert_redirected_to promotion_path(promotion)

    assert promotion.reload.approved?
    assert_equal 'Promoção aprovada com sucesso', flash[:notice]
  end

  test 'cannot approve if owner' do
    user = Fabricate(:user)
    promotion = Fabricate(:promotion, user: user)

    login_user(user)
    post approve_promotion_path(promotion)
    assert_redirected_to promotion_path(promotion)

    refute promotion.reload.approved?
    assert_equal 'Ação não permitida', flash[:alert]
  end
end