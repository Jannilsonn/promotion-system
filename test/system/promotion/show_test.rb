require 'application_system_test_case'

class SystemPromotionShowTest < ApplicationSystemTestCase
  test 'view promotion details' do
    user = login_user
    Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10',
                      discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    Promotion.create!(name: 'Cyber Monday',
                        coupon_quantity: 90,
                        description: 'Promoção de Cyber Monday',
                        code: 'CYBER15',
                        discount_rate: 15,
                        expiration_date: '22/12/2033',
                        user: user)
    
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    
    assert_text 'Natal'
    assert_text 'Promoção de Natal'
    assert_text '10,00%'
    assert_text 'NATAL10'
    assert_text '22/12/2033'
    assert_text '100'
  end
  

  test 'view details and return to promotions page' do
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
    click_on 'Natal'
    click_on 'Voltar - Promoções'

    assert_current_path promotions_path
  end
end