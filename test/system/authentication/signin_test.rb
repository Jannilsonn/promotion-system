require 'application_system_test_case'

class SystemAuthenticationSigninTest < ApplicationSystemTestCase
  test 'user sing in' do
    user = User.create!(name: 'Jane Doe', email: 'jane.doe@iugu.com.br', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'

    assert_text 'Login efetuado com sucesso!'
    assert_text user.email
    assert_current_path root_path
    assert_link 'Sair'
  end

  test 'user sign in and attributes cannot be blank' do
    visit new_user_session_path
    click_on 'Login'

    assert_text 'Email ou senha inválida'
  end
end