module LoginHelper
  def sign_out
    reset_session
    cookies.delete(:new_user)
    cookies.delete(:current_user)
  end

  def current_user
  	return User.find_by_remember_token(cookies[:current_user])
  end

  def json_to_root
  	render json: { redir_path: root_path }, status: 200
  end
end
