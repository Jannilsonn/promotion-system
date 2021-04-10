Fabricator(:category) do
  name 'Garantia'
  code { sequence(:code) { |i| "GARANTE#{i}" } }
end
