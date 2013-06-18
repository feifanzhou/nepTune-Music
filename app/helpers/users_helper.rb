module UsersHelper
	def get_user_from_params
    if !params[:username].blank?
      @user = User.find_by_username(params[:username].downcase)
      if @user.blank?
        not_found
      end
    end
	end

  def temporary_password
    return (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
  end
end
