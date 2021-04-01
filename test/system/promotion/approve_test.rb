require 'application_system_test_case'

class SystemPromotionApproveTest < ApplicationSystemTestCase
  test 'user approves promotion' do
    user = User.create!(name: 'Johnny Cage', email: 'johnny.cage@iugu.com.br', password: 'password')
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
                                  
    approver = login_user
    visit promotion_path(christmas)
    accept_confirm { click_on 'Aprovar' }

    assert_text 'Promoção aprovada com sucesso'
    assert_text "Aprovada por: #{approver.email}"
    assert_link 'Gerar cupons'
    refute_link 'Aprovar'
  end

  test 'user can not approves his promotion' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033',
                                  user: user)
    
    visit promotion_path(christmas)
    
    refute_link 'Aprovar'
  end
end