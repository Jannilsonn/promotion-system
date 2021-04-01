require 'application_system_test_case'

class SystemCategoryEditTest < ApplicationSystemTestCase
  test 'edit a category' do
    category = Category.create!(name: 'Garantia', code: 'GARANTE')

    visit category_path(category)
    click_on 'Editar - Categoria'

    fill_in 'Nome', with: 'AntiFraude'
    fill_in 'Código', with: 'ANTIFRA'
    click_on 'Atualizar categoria'
    
    assert_text 'AntiFraude'
    assert_text 'ANTIFRA'
end
end