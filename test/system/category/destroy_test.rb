require 'application_system_test_case'

class SystemCategoryDestroyTest < ApplicationSystemTestCase
  test 'delete a category' do
    category = Fabricate(:category)

    visit category_path(category)
    click_on 'Excluir - Categoria'

    assert_current_path categories_path
    assert_text 'Categoria excluída com sucesso'
  end
end
