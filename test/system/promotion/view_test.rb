require 'application_system_test_case'

class SystemPromotionViewTest < ApplicationSystemTestCase
  test 'view promotions' do
    user = login_user
    Fabricate(:promotion, name: 'Natal 1', user: user)
    Fabricate(:promotion, name: 'Cyber Monday 15',
              coupon_quantity: 90, code: 'CYBER15',
              description: 'Promoção de Cyber Monday', user: user)
    
    visit root_path
    click_on 'Promoções'

    assert_text 'Natal 1'
    assert_text 'Promoção de natal'
    assert_text '15,00%'
    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
  end

  test 'no promotion are available' do
    login_user
    visit root_path
    click_on 'Promoções'

    assert_text 'Nenhuma promoção cadastrada'
  end

  test 'view promotions and return to home page' do
    Fabricate(:promotion, user: login_user)
    
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar - Home'

    assert_current_path root_path
  end
end