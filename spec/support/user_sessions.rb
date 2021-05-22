module UserSessions
  def login_as(user)
    post '/api/v1/login', headers: { 'X-Requested-With': 'XMLHttpRequest' },
                           params: { email: user.email, password: 'Foobar0123' }
    expect(logged_in?).to be_truthy
  end

  def logged_in?
    !!current_user
  end
end