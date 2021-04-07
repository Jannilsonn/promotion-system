require 'application_system_test_case'

class SystemCouponSearchTest < ApplicationSystemTestCase
  test 'search coupon by term and finds a exact' do
    promotion = Fabricate(:promotion, code: 'NATAL1')
 
    approver = login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }
    click_on 'Gerar cupons'

    visit root_path
    click_on 'Cupons'
    fill_in 'Busca', with: 'NATAL1-0001'
    click_on 'Buscar'

    click_on 'NATAL1-0001'
    
    assert_text 'NATAL1-0001'
    assert_text 'habilitado'
    assert_text 'Natal'
  end

  test 'search coupon by term and find nothing' do
    promotion = Fabricate(:promotion)
 
    approver = login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }
    click_on 'Gerar cupons'

    visit root_path
    click_on 'Cupons'
    fill_in 'Busca', with: 'NATAL1-0000'
    click_on 'Buscar'
    
    assert_no_link 'NATAL1-0000'
    assert_text 'Nenhum resultado encontrado'
  end
end