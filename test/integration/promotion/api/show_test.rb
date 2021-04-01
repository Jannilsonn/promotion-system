require 'test_helper'

class IntegrationPromotionApiShowTest < ActionDispatch::IntegrationTest
  test 'show coupon'do
  user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
  promotion = Promotion.create!(name: 'Cyber Monday',
                                coupon_quantity: 100,
                                description: 'Promoção de Cyber Monday',
                                code: 'CYBER15',
                                discount_rate: 15,
                                expiration_date: '22/12/2033',
                                user: user)
    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    get "/api/v1/coupons/#{coupon.code}"

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
    assert_equal coupon.code, body[:code]
  end
end