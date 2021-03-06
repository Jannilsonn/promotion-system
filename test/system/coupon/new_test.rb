require 'application_system_test_case'

class SystemCouponNewTest < ApplicationSystemTestCase
  test 'generate coupons for a promotion' do
    promotion = Fabricate(:promotion, code: 'NATAL1')

    login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }
    click_on 'Gerar cupons'

    assert_text 'Cupons gerados com sucesso'
    assert_no_link 'Gerar cupons'
    assert_no_text 'NATAL1-0000'
    (1..100).each do |number|
      assert_text "NATAL1-#{format('%04d', number)}"
    end
    assert_no_text 'NATAL1-0101'
  end
end
