require 'test_helper'

class IntegrationPromotionApiNewTest < ActionDispatch::IntegrationTest
  test 'create promotion' do
    post '/api/v1/promotions', params: {
      promotion: Fabricate.attributes_for(:promotion,
                                          name: 'Natal 1',
                                          code: 'NATAL1',
                                          user: login_user)
    }, as: :json

    assert_response :success
    promotion = JSON.parse(response.body, symbolize_names: true)

    assert_equal promotion[:name], 'Natal 1'
    assert_equal promotion[:code], 'NATAL1'
  end

  test 'create and name/code must be unique' do
    user = login_user
    Fabricate(:promotion, name: 'Natal 1', code: 'NATAl1', user: user)

    post '/api/v1/promotions', params: {
      promotion: Fabricate.attributes_for(:promotion,
                                          name: 'Natal 1',
                                          code: 'NATAl1',
                                          user: user)
    }, as: :json

    assert_response :conflict
  end

  test 'create and attributes cannot be blank for promotion' do
    post '/api/v1/promotions', params: {
      promotion: {
        name: '',
        coupon_quantity: '',
        description: '',
        code: '',
        discount_rate: '',
        expiration_date: '',
        user: login_user
      }
    }, as: :json

    assert_response :conflict
  end
end
