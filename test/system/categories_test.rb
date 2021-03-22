require 'application_system_test_case'

class CategoriesTest < ApplicationSystemTestCase
    test 'list categories' do
        Category.create!(name: 'AntiFraude', code: 'ANTIFRA')
        Category.create!(name: 'Garantia', code: 'GARANTE')

        visit root_path
        click_on 'Categorias'

        assert_text 'AntiFraude'
        assert_text 'ANTIFRA'
        assert_text 'Garantia'
        assert_text 'GARANTE'
    end

    test 'view category details' do
        Category.create!(name: 'AntiFraude', code: 'ANTIFRA')
        category = Category.create!(name: 'Garantia', code: 'GARANTE')
        
        visit category_path(category)
        
        assert_text 'Garantia'
        assert_text 'GARANTE'
    end

    test 'create category' do
        visit categories_path
        click_on 'Registrar uma categoria'

        fill_in 'Nome', with: 'Garantia'
        fill_in 'Código', with: 'GARANTE'

        click_on 'Criar categoria'
        assert_text 'Garantia'
        assert_text 'GARANTE'
    end

    test 'create and attributes cannot be blank' do
        visit categories_path
        click_on 'Registrar uma categoria'
        click_on 'Criar categoria'

        assert_text 'não pode ficar em branco', count: 2
    end

    test 'create and code must be unique' do
        Category.create!(name: 'Garantia', code: 'GARANTE')

        visit categories_path
        click_on 'Registrar uma categoria'

        fill_in 'Nome', with: 'Garantia'
        fill_in 'Código', with: 'GARANTE'
        click_on 'Criar categoria'

        assert_text 'deve ser único'
    end

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

    test 'delete a category' do
        category = Category.create!(name: 'Garantia', code: 'GARANTE')

        visit category_path(category)
        click_on 'Excluir - Categoria'

        assert_current_path categories_path
        assert_text 'Categoria excluída com sucesso'
    end
end