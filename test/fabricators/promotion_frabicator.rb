Fabricator(:promotion) do
  name { sequence(:name) { |i| "Natal #{i}" } }
  coupon_quantity 100
  description 'Promoção de natal'
  code { sequence(:code) { |i| "NATAL#{i}" } }
  discount_rate 15
  expiration_date '22/12/2033'
  user
end