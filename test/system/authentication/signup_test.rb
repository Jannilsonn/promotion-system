require 'application_system_test_case'

class SystemAuthenticationSignupTest < ApplicationSystemTestCase
  test 'user sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Cadastrar'

    assert_text 'Boas vindas! Cadastrou e entrou com suceso'
    assert_text 'jane.doe@iugu.com.br'
    assert_link 'Sair'
    assert_current_path root_path
  end

  test 'user sign up and attributes cannot be blank' do
    visit new_user_registration_path
    click_on 'Cadastrar'

    assert_text 'Senha não pode ficar em branco'
    assert_text 'Email não pode ficar em branco'
  end
end
