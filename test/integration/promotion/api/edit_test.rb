require 'test_helper'

class IntegrationPromotionApiEditTest < ActionDispatch::IntegrationTest
  test 'edit promotion' do
    promotion = Fabricate(:promotion, name: 'Natal 1', code: 'NATAL1')

    put api_v1_promotion_path(id: promotion.id,
                              promotion: Fabricate
                                .attributes_for(:promotion,
                                                name: 'Natal 2',
                                                code: 'NATAL2')),
                                                as: :json

    assert_response :success
    promotion = JSON.parse(response.body, symbolize_names: true)
    
    assert_equal promotion[:name], 'Natal 2'
    assert_equal promotion[:code], 'NATAL2'
  end
end