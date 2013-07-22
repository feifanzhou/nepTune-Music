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

  def route_from_artistname(name)
    regexp = %r{[^a-z0-9\-._~#\[\]@!$&()*+,;]}
    name.strip.downcase.gsub(regexp, "")
  end

  def create_user(params)
    input = params[:user]
    if input.blank?
      input = params[:login]
    end

    fullAccountCreate = input[:fullAccountCreate].to_i

    isArtist = input[:isArtist].to_i

    @user = User.new(input.except(:fullAccountCreate, :artistname))
    @user.isArtist = (isArtist == 1)

    should_save = @user.valid?

    # TODO: check for artist name duplicates

    session[:new_user] = @user.id
    if should_save && @user.save
      save_user_to_cookie(@user)
      if isArtist == 1
        route = route_from_artistname(input[:artistname])
        contact_info = ContactInfo.create
        artist = Artist.create(artistname: input[:artistname], route: route, contact_info: contact_info)
        member = BandMember.create(user_id: @user.id, artist_id: artist.id)
      end
    elsif fullAccountCreate.blank? or fullAccountCreate == 0
      email = input[:email]
      # TODO: This is an awful security hole. Needs to be fixed!
      if (!email.blank?)  # If they enter an existing email, sign them in
        @user = User.find_by_email(email)
        if @user
          save_user_to_cookie(@user)
        end
      end
    end

    return @user
  end
end
