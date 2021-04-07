require 'test_helper'

class IntegrationPromotionApiShowTest < ActionDispatch::IntegrationTest
  test 'show coupon'do
    coupon = Fabricate(:coupon, code: 'NATAL0-0001')

    get "/api/v1/coupons/#{coupon.code}", as: :json

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
    assert_equal coupon.code, body[:code]
    assert_equal coupon.discount_rate.to_s, body[:discount_rate]
  end

  test 'show coupon not found' do
    get "/api/v1/coupons/0", as: :json

    assert_response :not_found
  end

  test 'show invalid without header' do
    assert_raises ActionController::RoutingError do
      get "/api/v1/coupons/0"
    end
  end

  test 'show coupon disabled' do
    coupon = Fabricate(:coupon, code: 'NATAL0-0001')

    get "/api/v1/coupons/0", as: :json

    assert_response :not_found
  end
end