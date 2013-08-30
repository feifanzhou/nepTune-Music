def rand_case str
  res = ''
  str.size.times do |i|
    res << str[i].chr.send(rand >= 0.5 ? :upcase : :downcase)
  end
  res
end

def sign_out
  visit logout_path
end

def sign_in_as(user, opts = {password: nil})
  sign_out
  visit login_path
  pass = opts[:password] || user.password
  fill_in "Email",    with: user.email
  fill_in "Password", with: pass
  click_button "Log in"
  # Sign in when not using Capybara as well.
  #request.cookies[:current_user] = user.remember_token
end
