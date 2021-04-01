require 'application_system_test_case'

class SystemPromotionViewTest < ApplicationSystemTestCase
  test 'view promotions' do
    user = login_user
    Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    Promotion.create!(name: 'Cyber Monday',
                      coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15',
                      discount_rate: 15,
                      expiration_date: '22/12/2033',
                      user: user)
    
    visit root_path
    click_on 'Promoções'

    assert_text 'Natal'
    assert_text 'Promoção de Natal'
    assert_text '10,00%'
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
    user = login_user
    Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10',
                      discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)

    
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar - Home'

    assert_current_path root_path
  end
end