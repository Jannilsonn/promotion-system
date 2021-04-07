Fabricator(:promotion) do
  name { sequence(:name) { |i| "Natal #{i + 1}" } }
  coupon_quantity 100
  description 'Promoção de natal'
  code { sequence(:code) { |i| "NATAL#{i + 1}" } }
  discount_rate 15
  expiration_date '22/12/2033'
  user
end