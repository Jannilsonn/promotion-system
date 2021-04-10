module LoginJane
  def login_user(user = User.create!(name: 'Jane Doe', email: 'jane.doe@iugu.com.br', password: 'password'))
    login_as user, scope: :user
    user
  end
end
