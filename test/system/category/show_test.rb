require 'application_system_test_case'

class SystemCategoryShowTest < ApplicationSystemTestCase
  test 'view category details' do
    Fabricate(:category)
    category = Fabricate(:category, name: 'Antifraude', code: 'ANTIFRA0')

    visit category_path(category)

    assert_text 'Antifraude'
    assert_text 'ANTIFRA0'
  end
end
