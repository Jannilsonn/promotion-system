require 'application_system_test_case'

class SystemPromotionEditTest < ApplicationSystemTestCase
  test 'edit a promotion' do
    promotion = Fabricate(:promotion, user: login_user)               
    
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

  test 'edit and attributes cannot be blank for promotion' do
    promotion = Fabricate(:promotion, name: 'Natal 1', user: login_user)
    
    visit edit_promotion_path(promotion)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Atualizar Promoção'

    assert_text 'não pode ficar em branco', count: 5
  end
end