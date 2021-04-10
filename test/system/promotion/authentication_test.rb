require 'application_system_test_case'

class SystemPromotionAuthenticationTest < ApplicationSystemTestCase
  test 'do not view promotion link without login' do
    visit root_path

    assert_no_link 'Promoções'
  end

  test 'do not view promotions using route without login' do
    visit promotions_path

    assert_current_path new_user_session_path
  end
end
