require 'application_system_test_case'

class SystemCategoryNewTest < ApplicationSystemTestCase
  test 'create category' do
    visit categories_path
    click_on 'Registrar uma categoria'

    fill_in 'Nome', with: 'Garantia'
    fill_in 'Código', with: 'GARANTE'

    click_on 'Criar categoria'
    assert_text 'Garantia'
    assert_text 'GARANTE'
  end

  test 'create and attributes cannot be blank for category' do
    visit categories_path
    click_on 'Registrar uma categoria'
    click_on 'Criar categoria'

    assert_text 'não pode ficar em branco', count: 2
  end

  test 'create and code must be unique' do
    Category.create!(name: 'Garantia', code: 'GARANTE')

    visit categories_path
    click_on 'Registrar uma categoria'

    fill_in 'Nome', with: 'Garantia'
    fill_in 'Código', with: 'GARANTE'
    click_on 'Criar categoria'

    assert_text 'já está em uso'
  end
end