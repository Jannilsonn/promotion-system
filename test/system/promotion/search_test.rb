require 'application_system_test_case'

class SystemPromotionSearchTest < ApplicationSystemTestCase
  test 'search promotion by term and finds a exact' do
    user = login_user
    christmas = Fabricate(:promotion, user: user)
    cyber_monday = Fabricate(:promotion, name: 'Cyber Monday 0',
                                         coupon_quantity: 90, code: 'CYBER15',
                                         description: 'Promoção de Cyber Monday', user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'natal'
    click_on 'Buscar'

    assert_text christmas.name
    assert_no_text cyber_monday.name
  end

  test 'search promotion by term and finds results' do
    user = login_user
    christmas = Fabricate(:promotion, user: user)
    christmassy = Fabricate(:promotion, name: 'Natalina 0',
                                        code: 'NATALINA20', discount_rate: 10,
                                        description: 'Promoção Natalina', user: user)
    Fabricate(:promotion, name: 'Cyber Monday 0',
                          coupon_quantity: 90, code: 'CYBER15',
                          description: 'Promoção de Cyber Monday', user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'nat'
    click_on 'Buscar'

    assert_text christmas.name
    assert_text christmassy.name
  end

  test 'search promotion by term and finds nothing' do
    user = login_user
    Fabricate(:promotion, user: user)
    Fabricate(:promotion,
              name: 'Cyber Monday 0',
              coupon_quantity: 90,
              code: 'CYBER15',
              description: 'Promoção de Cyber Monday',
              user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Busca', with: 'carnaval'
    click_on 'Buscar'
    assert_text 'Nenhum resultado'
  end
end
