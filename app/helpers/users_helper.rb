# -*- coding: utf-8 -*-
module UsersHelper
  # TODO: Organize methods in alphabetical order
  def get_user_from_params
    # TODO: Find by other parameters, including id, facebook_id, and email
    # TODO: Don't use username anymore
    if !params[:username].blank?
      @user = User.find_by_username(params[:username].downcase)
      if @user.blank?
        not_found
      end
    end
  end

  def has_facebook_id(a_user)
    return !a_user.facebook_id.nil? && a_user.facebook_id.to_i > 0   # It actually looks like facebook IDs 1–3 don't return anything
  end

  def save_user_to_cookie(a_user)
    if a_user.has_temp_password && !has_facebook_id(a_user)
      cookies[:new_user] = { value: a_user.id, expires: 20.years.from_now }
    else
      cookies[:current_user] = { value: a_user.remember_token, expires: 20.years.from_now }
    end
  end

  def temporary_password
    return (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  BAD_WORDS = ['cunt', 'faggot', 'fuck', 'fuq', 'hoes', 'hoez', 'jizz', 'nigger', 'nigga', 'suck', 'sucker', 'poop']

  def is_profane_name?(name)
    if name.blank?
      return false
    else
      n = name.downcase
    end
    BAD_WORDS.each do |t|
      if n.include? t
        return true
      end
    end
    return false
  end

  def update_user_for_facebook_login(a_user, input)
    # a_user.facebook_id = input[:facebook_id].to_i
    # a_user.password = input[:password] if a_user.has_temp_password
    # a_user.save

    # update_column to bypass validation (was getting some issues with the password not being 6 characters)
    a_user.update_column(:facebook_id, input[:facebook_id])
  end

  def user_exists_by_email(target_email)
    return !(User.find_by_email(target_email).blank?)
  end


  # TODO: I feel like this method should return the user, and there should be another method that saves and logins in etc.
  # This way, I can set other, hidden properties on the user like facebook_id
  # The use of this method in Logins#fb_login prompted this thought
  def create_user(params)
    input = params[:user]
    if input.blank?
      input = params[:login]
    end
    # FB Login—check if email already exists
    # If it does, update user with Facebook ID and return
    # emUser = User.find_by_email(input[:email].downcase)
    # if !emUser.blank?
    #   update_user_for_facebook_login(emUser, input)
    #   save_user_to_cookie(emUser)
    #   return true
    # end
    # ?? Above could be written as
    # update_user_with_facebook_id(emUser, input[:facebook_id]) if !emUser.blank? and return

    fullAccountCreate = input[:fullAccountCreate].to_i
    # if fullAccountCreate and !emUser.blank? # Signing up when email already exists
    #   flash[:login_error] = "You're already registered! Sign in below"
    # end
    isArtist = input[:isArtist].to_i
    # @user = (isArtist == 1) ? Artist.new(input.except(:fullAccountCreate)) : User.new(input.except(:fullAccountCreate, :username))
    @user = User.new(input.except(:fullAccountCreate, :artistname))

    should_save = @user.valid?

    # TODO: check for artist name duplicates

    # TODO: Show message if signing up with an email that already exists
    session[:new_user] = @user.id
    if should_save && @user.save
      save_user_to_cookie(@user)
      if isArtist == 1
        artist = Artist.create(:artistname => input[:artistname])
        member = BandMember.create(user_id: @user.id, artist_id: artist.id)
      end
    elsif fullAccountCreate.blank? or fullAccountCreate == 0
      if (!email.blank?)  # If they enter an existing email, sign them in
        @user = User.find_by_email(email)
        if @user
          save_user_to_cookie(@user)
        end
      end
    end

    return @user.errors
  end
end
