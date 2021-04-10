require 'application_system_test_case'

class SystemCategoryViewTest < ApplicationSystemTestCase
  test 'list categories' do
    Fabricate(:category, code: 'GARANTE1')
    Fabricate(:category, name: 'Antifraude', code: 'ANTIFRA1')

    login_user
    visit root_path
    click_on 'Categorias'

    assert_text 'Antifraude'
    assert_text 'ANTIFRA1'
    assert_text 'Garantia'
    assert_text 'GARANTE1'
  end
end
