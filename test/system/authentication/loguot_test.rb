require 'application_system_test_case'

class SystemAuthenticationLogoutTest < ApplicationSystemTestCase
  test 'user log out' do
    login_user
    visit root_path
    click_on 'Sair'

    assert_current_path new_user_session_path
  end
end
