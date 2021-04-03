require "test_helper"

class ModelCouponSearchTest < ActiveSupport::TestCase
  test '.search by exact' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    
    promotion.generate_coupons!

    result = Coupon.search('NATAL10-0001')
    assert_includes result.code, 'NATAL10-0001'
    assert_includes result.promotion.name, 'Natal'
  end

  test '.search and find nothing' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    promotion = Promotion.create!(name: 'Natal',
                      description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 100,
                      expiration_date: '22/12/2033',
                      user: user)
    
    promotion.generate_coupons!

    result = Coupon.search('NATAL10-0000')
    assert_nil result
  end
end