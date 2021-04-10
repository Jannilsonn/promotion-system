require 'test_helper'

class IntegrationPromotionApiNewTest < ActionDispatch::IntegrationTest
  test 'create promotion' do
    post '/api/v1/promotions', params: {
      promotion: Fabricate.attributes_for(:promotion, name: 'Natal 1', code: 'NATAL1')
    }
    
    assert_response :success
  end
end