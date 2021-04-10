require 'test_helper'

class ModelPromotionNewTest < ActiveSupport::TestCase
  test 'attributes cannot be blank' do
    promotion = Promotion.new

    assert_not promotion.valid?
    assert_includes promotion.errors[:name], 'não pode ficar em branco'
    assert_includes promotion.errors[:code], 'não pode ficar em branco'
    assert_includes promotion.errors[:discount_rate], 'não pode ficar em '\
                                                      'branco'
    assert_includes promotion.errors[:coupon_quantity], 'não pode ficar em'\
                                                        ' branco'
    assert_includes promotion.errors[:expiration_date], 'não pode ficar em'\
                                                        ' branco'
  end

  test 'code must be uniq' do
    Fabricate(:promotion, code: 'NATAL1')
    promotion = Promotion.new(code: 'NATAL1')

    assert_not promotion.valid?
    assert_includes promotion.errors[:code], 'já está em uso'
  end

  test 'name must be uniq' do
    Fabricate(:promotion, name: 'Natal 1')
    promotion = Promotion.new(name: 'Natal 1')

    assert_not promotion.valid?
    assert_includes promotion.errors[:name], 'já está em uso'
  end
end
