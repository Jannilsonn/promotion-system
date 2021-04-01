require 'application_system_test_case'

class SystemUserEditTest < ApplicationSystemTestCase
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