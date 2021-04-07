require 'application_system_test_case'

class SystemPromotionShowTest < ApplicationSystemTestCase
  test 'view promotion details' do
    user = login_user
    Fabricate(:promotion, user: user)
    Fabricate(:promotion, name: 'Cyber Monday 0',
              coupon_quantity: 90, code: 'CYBER15',
              description: 'Promoção de Cyber Monday', user: user)
    
    visit root_path
    click_on 'Promoções'
    click_on 'Natal 0'
    
    assert_text 'Natal 0'
    assert_text 'Promoção de natal'
    assert_text '15,00%'
    assert_text 'NATAL0'
    assert_text '22/12/2033'
    assert_text '100'
  end
  

  test 'view details and return to promotions page' do
    Fabricate(:promotion, user: login_user)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal 0'
    click_on 'Voltar - Promoções'

    assert_current_path promotions_path
  end
end