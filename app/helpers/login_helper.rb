module LoginHelper
  def sign_out
    reset_session
    cookies.delete(:new_user)
    cookies.delete(:current_user)
  end
end
