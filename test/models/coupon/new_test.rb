require "test_helper"

class ModelCouponNewTest < ActiveSupport::TestCase
  test 'generate_coupons! successfully' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    
    promotion.generate_coupons!
    assert_equal promotion.coupons.size, promotion.coupon_quantity
    assert_equal promotion.coupons.first.code, 'NATAL10-0001'
  end

  test 'generate_coupons! connot be called twice' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    
    Coupon.create!(code: 'NATAL10', promotion: promotion)
    assert_no_difference 'Coupon.count' do
      promotion.generate_coupons!
    end
  end
end