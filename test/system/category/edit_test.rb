require 'application_system_test_case'

class SystemCategoryEditTest < ApplicationSystemTestCase
  test 'edit a category' do
    category = Fabricate(:category)

    visit category_path(category)
    click_on 'Editar - Categoria'

    fill_in 'Nome', with: 'Antifraude'
    fill_in 'Código', with: 'ANTIFRA0'
    click_on 'Atualizar Categoria'
    
    assert_text 'Antifraude'
    assert_text 'ANTIFRA0'
  end

  test 'edit and attributes cannot be blank for category' do
    category = Fabricate(:category)

    visit category_path(category)
    click_on 'Editar - Categoria'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Atualizar Categoria'
    
    assert_text 'não pode ficar em branco', count: 2
  end
end