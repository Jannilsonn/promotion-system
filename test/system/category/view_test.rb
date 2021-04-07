require 'application_system_test_case'

class SystemCategoryViewTest < ApplicationSystemTestCase
  test 'list categories' do
    Fabricate(:category)
    Fabricate(:category, name: 'Antifraude', code: 'ANTIFRA0')

    login_user
    visit root_path
    click_on 'Categorias'

    assert_text 'Antifraude'
    assert_text 'ANTIFRA0'
    assert_text 'Garantia'
    assert_text 'GARANTE0'
  end
end