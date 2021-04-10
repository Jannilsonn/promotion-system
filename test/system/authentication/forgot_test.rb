require 'application_system_test_case'

class SystemAuthenticationForgotTest < ApplicationSystemTestCase
  test 'user send instructions forgot password' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Esqueceu sua senha?'

    fill_in 'Email', with: user.email
    click_on 'Enviar instruções para redefinição da senha'
    assert_text 'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.'
  end

  test 'user reset password' do
    user = Fabricate(:user)

    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)

    fill_in 'Nova Senha', with: 'newpassword'
    fill_in 'Confirme sua nova senha', with: 'newpassword'
    click_on 'Alterar minha senha'
    assert_text 'Sua senha foi alterada com sucesso. Você está logado.'
  end
end
