require 'application_system_test_case'

class SystemPromotionSearchTest < ApplicationSystemTestCase
  test 'search promotion by term and finds a exact' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'natal'
    click_on 'Buscar'

    assert_text christmas.name
    assert_no_text cyber_monday.name
  end

  test 'search promotion by term and finds results' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    christmassy = Promotion.create!(name: 'Natalina',
                                    description: 'Promoção Natalina',
                                    code: 'NATALINA20', discount_rate: 10,
                                    coupon_quantity: 100,
                                    expiration_date: '22/12/2033',
                                    user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    
    
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'nat'
    click_on 'Buscar'

    assert_text christmas.name
    assert_text christmassy.name
  end

  test 'search promotion by term and finds nothing' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    
    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'carnaval'
    click_on 'Buscar'
    assert_text 'Nenhum resultado'
  end
end