require 'application_system_test_case'

class SystemPromotionApproveTest < ApplicationSystemTestCase
  test 'user approves promotion' do
    christmas = Fabricate(:promotion)

    approver = login_user
    visit promotion_path(christmas)
    accept_confirm { click_on 'Aprovar' }

    assert_text 'Promoção aprovada com sucesso'
    assert_text "Aprovada por: #{approver.email}"
    assert_link 'Gerar cupons'
    refute_link 'Aprovar'
  end

  test 'user can not approves his promotion' do
    christmas = Fabricate(:promotion, user: login_user)

    visit promotion_path(christmas)

    refute_link 'Aprovar'
  end
end
