require 'application_system_test_case'

class SystemPromotionDestroyTest < ApplicationSystemTestCase
  test 'delete a promotion' do
    user = login_user
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, 
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)

    
    visit promotion_path(promotion)
    assert_link 'Excluir - Promoção'

    click_on 'Excluir - Promoção'
    assert_current_path promotions_path
    assert_text 'Promoção excluída com sucesso'
  end
end