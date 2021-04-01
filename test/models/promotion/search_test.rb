require "test_helper"

class ModelPromotionSearchTest < ActiveSupport::TestCase
  test '.search by exact' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    result = Promotion.search('Natal')
    assert_includes result, christmas
    refute_includes result, cyber_monday
  end

  test '.search by partial' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    christmassy = Promotion.create!(name: 'Natalina',
                                  description: 'Promoção Natalina',
                                  code: 'NATALINA20', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    result = Promotion.search('Natal')
    assert_includes result, christmas
    assert_includes result, christmassy
    refute_includes result, cyber_monday
  end

  test '.search not things' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033',
                                    user: user)
    result = Promotion.search('Carnaval')
    assert_empty result
  end
end