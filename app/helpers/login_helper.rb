module LoginHelper
  def sign_out
    reset_session
    cookies.delete(:new_user)
  end
end
