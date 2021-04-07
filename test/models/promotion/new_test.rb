require "test_helper"

class ModelPromotionNewTest < ActiveSupport::TestCase
  test 'attributes cannot be blank' do
    promotion = Promotion.new

    refute promotion.valid?
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
    Fabricate(:promotion, code: 'NATAL0')
    promotion = Promotion.new(code: 'NATAL0')

    refute promotion.valid?
    assert_includes promotion.errors[:code], 'já está em uso'
  end

  test 'name must be uniq' do
    Fabricate(:promotion, name: 'Natal0')
    promotion = Promotion.new(name: 'Natal0')

    refute promotion.valid?
    assert_includes promotion.errors[:name], 'já está em uso'
  end
end