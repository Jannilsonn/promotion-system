require 'application_system_test_case'

class SystemPromotionEditTest < ApplicationSystemTestCase
  test 'edit a promotion' do
    user = login_user
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10, 
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
                                  
    
    visit promotion_path(promotion)
    assert_link 'Editar - Promoção'

    click_on 'Editar - Promoção'
    assert_current_path edit_promotion_path(promotion)

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Atualizar Promoção'

    visit promotion_path(promotion)
    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
    assert_text 'CYBER15'
    assert_text '22/12/2033'
    assert_text '90'
  end
end