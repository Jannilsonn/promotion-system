require 'application_system_test_case'

class SystemCouponStatusTest < ApplicationSystemTestCase
  test 'disable a coupon' do
    promotion = Fabricate(:promotion, user: login_user)
    
    promotion.generate_coupons!

    visit promotion_path(promotion)
    within 'div#coupon-natal0-0001' do
      click_on 'Desabilitar'
    end

    assert_text 'Cupom NATAL0-0001 desabilitado com sucesso'
    assert_text 'NATAL0-0001 (desabilitado)'
    within 'div#coupon-natal0-0001' do
      assert_no_link 'Desabilitar'
    end
    assert_link 'Desabilitar', count: promotion.coupon_quantity - 1
  end

  test 'active a coupon' do
    promotion = Fabricate(:promotion, user: login_user)
    
    promotion.generate_coupons!

    visit promotion_path(promotion)
    within 'div#coupon-natal0-0001' do
      click_on 'Desabilitar'
    end
    within 'div#coupon-natal0-0001' do
      click_on 'Habilitar'
    end

    assert_text 'Cupom NATAL0-0001 habilitado com sucesso'
    assert_text 'NATAL0-0001 (habilitado)'
    within 'div#coupon-natal0-0001' do
      assert_no_link 'Habilitar'
    end
    assert_link 'Desabilitar', count: promotion.coupon_quantity
  end
end