Fabricator(:user) do
  name 'Johnny Cage'
  email { sequence(:email) { |i| "johnny.cage#{i}@iugu.com.br" } }
  password 'password'
end
