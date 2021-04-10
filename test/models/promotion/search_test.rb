require 'test_helper'

class ModelPromotionSearchTest < ActiveSupport::TestCase
  test '.search by exact' do
    christmas = Fabricate(:promotion, name: 'Natal 0')
    cyber_monday = Fabricate(:promotion, name: 'Cyber Monday 0',
                                         coupon_quantity: 90, code: 'CYBER0',
                                         description: 'Promoção de Cyber Monday')

    result = Promotion.search('Natal 0')
    assert_includes result, christmas
    assert_not_includes result, cyber_monday
  end

  test '.search by partial' do
    christmas = Fabricate(:promotion)
    christmassy = Fabricate(:promotion, name: 'Natalina 0',
                                        code: 'NATALINA0', discount_rate: 10,
                                        description: 'Promoção Natalina')
    cyber_monday = Fabricate(:promotion, name: 'Cyber Monday 0',
                                         coupon_quantity: 90, code: 'CYBER0',
                                         description: 'Promoção de Cyber Monday')

    result = Promotion.search('Natal')
    assert_includes result, christmas
    assert_includes result, christmassy
    assert_not_includes result, cyber_monday
  end

  test '.search not things' do
    Fabricate(:promotion)
    Fabricate(:promotion, name: 'Cyber Monday 0',
                          coupon_quantity: 90, code: 'CYBER0',
                          description: 'Promoção de Cyber Monday')

    result = Promotion.search('Carnaval')
    assert_empty result
  end
end
