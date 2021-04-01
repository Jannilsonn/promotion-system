require 'application_system_test_case'

class SystemCategoryShowTest < ApplicationSystemTestCase
  test 'view category details' do
    Category.create!(name: 'AntiFraude', code: 'ANTIFRA')
    category = Category.create!(name: 'Garantia', code: 'GARANTE')
    
    visit category_path(category)
    
    assert_text 'Garantia'
    assert_text 'GARANTE'
  end
end