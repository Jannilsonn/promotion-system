require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
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

  test 'user log out' do
    login_user
    visit root_path
    click_on 'Sair'

    assert_current_path new_user_session_path
  end

  test 'user send instructions forgot password' do
    user = User.create!(name: 'Jane Doe', email: 'jane.doe@iugu.com.br', password: 'password')

    visit root_path
    click_on 'Esqueceu sua senha?'

    fill_in 'Email', with: user.email
    click_on 'Enviar instruções para redefinição da senha'
    assert_text 'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.'
  end

  test 'user reset password' do
    # user = User.create!(name: 'Jane Doe', email: 'jane.doe@iugu.com.br', password: 'password')
    # visit edit_user_password_path()
    # user.reset_password_token
  end
  
  test 'edit name user' do
    login_user
    visit root_path
    click_on 'Editar'

    fill_in 'Nome', with: 'Jane Doe'
    fill_in 'Senha atual', with: 'password'
    click_on 'Atualizar'
    assert_text 'Sua conta foi atualizada com sucesso.'
  end

  test 'edit user email' do
    login_user
    visit root_path
    click_on 'Editar'

    fill_in 'Email', with: 'jane@iugu.com.br'
    fill_in 'Senha atual', with: 'password'
    click_on 'Atualizar'
    assert_text 'Sua conta foi atualizada com sucesso.'
  end

  test 'edit user password' do
    login_user
    visit root_path
    click_on 'Editar'
    
    fill_in 'Senha', with: 'newpassword'
    fill_in 'Confirme sua senha', with: 'newpassword'
    fill_in 'Senha atual', with: 'password'
    click_on 'Atualizar'
    assert_text 'Sua conta foi atualizada com sucesso.'
  end

  test 'edit all user attributes' do
    login_user
    visit root_path
    click_on 'Editar'
    
    fill_in 'Nome', with: 'Jane Doe'
    fill_in 'Email', with: 'jane@iugu.com.br'
    fill_in 'Senha', with: 'newpassword'
    fill_in 'Confirme sua senha', with: 'newpassword'
    fill_in 'Senha atual', with: 'password'
    click_on 'Atualizar'
    assert_text 'Sua conta foi atualizada com sucesso.'
  end
end