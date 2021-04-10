require 'test_helper'

class IntegrationPromotionApiShowTest < ActionDispatch::IntegrationTest
  test 'show promotion' do
    promotion = Fabricate(:promotion, name: 'Natal 1', code: 'NATAL1')

    get "/api/v1/promotions/#{promotion.id}", as: :json
    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)

    assert_equal promotion.name, body[:name]
    assert_equal promotion.code, body[:code]
  end

  test 'show promotion not found' do
    get '/api/v1/promotions/0', as: :json

    assert_response :not_found
  end

  test 'show invalid without header' do
    assert_raises ActionController::RoutingError do
      get '/api/v1/promotions/0'
    end
  end
end
