require 'application_system_test_case'

class SystemCategoryViewTest < ApplicationSystemTestCase
  test 'list categories' do
    Category.create!(name: 'AntiFraude', code: 'ANTIFRA')
    Category.create!(name: 'Garantia', code: 'GARANTE')

    login_user
    visit root_path
    click_on 'Categorias'

    assert_text 'AntiFraude'
    assert_text 'ANTIFRA'
    assert_text 'Garantia'
    assert_text 'GARANTE'
  end
end