module LoginHelper
  def sign_out
    reset_session
    cookies.delete(:new_user)
    cookies.delete(:current_user)
  end

  def is_logged_in
    return !(current_user.blank?)
  end

  def current_user
    if !(cookies[:current_user].blank?)
      User.find_by_remember_token(cookies[:current_user])
    else
      nil
    end
  end

  def json_to_path(path)
    render json: { redir_path: path }, status: 200
  end

  def json_to_root
    render json: { redir_path: root_path }, status: 200
  end

  def redirect_if_not_logged_in
    if not is_logged_in
      redirect_to login_path
    end
  end

  def redirect_if_user_does_not_match(user)
    if is_logged_in and current_user.id != user.id
      redirect_to root_path
    end
  end
end
