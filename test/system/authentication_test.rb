require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
  test 'user sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmação de senha', with: 'password'
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

  test 'user sing in' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    assert_text 'Login efetuado com sucesso!'
    assert_text user.email
    assert_current_path root_path
    assert_link 'Sair'
  end

  test 'user sign in and attributes cannot be blank' do
    visit new_user_session_path
    click_on 'Log in'

    assert_text 'Email ou senha inválida'
  end

  test 'user log out' do
    login_user
    visit root_path
    click_on 'Sair'

    assert_current_path new_user_session_path
  end

  # TODO: Teste o recuperar senha
  # TODO: Teste o editar o usuário
  # TODO: I18n do user
  # TODO: incluir name no user
end