require 'application_system_test_case'

class NewCouponTest < ApplicationSystemTestCase
  test 'generate coupons for a promotion' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10, 
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)

                                      
    approver = login_user
    visit promotion_path(promotion)
    accept_confirm { click_on 'Aprovar' }

    click_on 'Gerar cupons'

    assert_text 'Cupons gerados com sucesso'
    assert_no_link 'Gerar cupons'
    assert_no_text 'NATAL10-0000'
    (1..100).each do |number|
      assert_text "NATAL10-#{'%04d' % number}"
    end
    assert_no_text 'NATAL10-0101'
  end
end