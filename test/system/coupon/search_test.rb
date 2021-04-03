require 'application_system_test_case'

class SystemCouponSearchTest < ApplicationSystemTestCase
  test 'search coupon by term and finds a exact' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10, 
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
 
    approver = login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }

    click_on 'Gerar cupons'

    visit root_path
    click_on 'Cupons'
    fill_in 'Busca', with: 'NATAL10-0001'
    click_on 'Buscar'

    click_on 'NATAL10-0001'
    
    assert_text 'NATAL10-0001'
    assert_text 'habilitado'
    assert_text 'Natal'
  end

  test 'search coupon by term and find nothing' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10, 
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
 
    approver = login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }

    click_on 'Gerar cupons'

    visit root_path
    click_on 'Cupons'
    fill_in 'Busca', with: 'NATAL10-0000'
    click_on 'Buscar'
    
    assert_no_link 'NATAL10-0000'
    assert_text 'Nenhum resultado encontrado'
  end
end