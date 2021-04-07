require 'application_system_test_case'

class SystemCategoryEditTest < ApplicationSystemTestCase
  test 'edit a category' do
    category = Fabricate(:category)

    visit category_path(category)
    click_on 'Editar - Categoria'

    fill_in 'Nome', with: 'Antifraude'
    fill_in 'Código', with: 'ANTIFRA0'
    click_on 'Atualizar categoria'
    
    assert_text 'Antifraude'
    assert_text 'ANTIFRA0'
end
end