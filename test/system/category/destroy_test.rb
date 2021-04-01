require 'application_system_test_case'

class SystemCategoryDestroyTest < ApplicationSystemTestCase
  test 'delete a category' do
    category = Category.create!(name: 'Garantia', code: 'GARANTE')

    visit category_path(category)
    click_on 'Excluir - Categoria'

    assert_current_path categories_path
    assert_text 'Categoria excluída com sucesso'
  end
end