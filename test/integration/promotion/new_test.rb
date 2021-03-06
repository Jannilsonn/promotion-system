require 'test_helper'

class IntegrationPromotionNewTest < ActionDispatch::IntegrationTest
  test 'can create a promotion' do
    login_user
    post '/promotions', params: {
      promotion: Fabricate.attributes_for(:promotion, name: 'Natal 1')
    }

    assert_redirected_to promotion_path(Promotion.first)
    follow_redirect!
    assert_select 'h3', 'Natal 1'
  end

  test 'cannot create a promotion without login' do
    post '/promotions', params: {
      promotion: Fabricate.attributes_for(:promotion)
    }

    assert_redirected_to new_user_session_path
  end
end
