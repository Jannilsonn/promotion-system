require 'test_helper'

class IntegrationPromotionApiEditTest < ActionDispatch::IntegrationTest
  test 'edit promotion' do
    promotion = Fabricate(:promotion, name: 'Natal 1', code: 'NATAL1')

    put api_v1_promotion_path(id: promotion.id,
                              promotion: Fabricate
                                .attributes_for(:promotion,
                                                name: 'Natal 2',
                                                code: 'NATAL2'))

    assert_response :success
  end
end