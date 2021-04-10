require 'application_system_test_case'

class SystemPromotionDestroyTest < ApplicationSystemTestCase
  test 'delete a promotion' do
    promotion = Fabricate(:promotion, user: login_user)

    visit promotion_path(promotion)
    assert_link 'Excluir - Promoção'

    click_on 'Excluir - Promoção'
    assert_current_path promotions_path
    assert_text 'Promoção excluída com sucesso'
  end
end
