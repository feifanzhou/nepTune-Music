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

  def is_profane_name?(name)
    terms = ['cunt', 'faggot', 'fuck', 'fuq', 'hoes', 'hoez', 'jizz', 'nigger', 'nigga', 'suck', 'sucker', 'poop']
    terms.each do |t|
      if name.downcase.include? t
        return true
      end
    end
    return false
  end

  def create_user(params)
    input = params[:user]
    if input.blank?
      input = params[:login]
    end
    fullAccountCreate = input[:fullAccountCreate].to_i
    if fullAccountCreate and User.find_by_email(input[:email].downcase) # Signing up when email already exists
      flash[:login_error] = "You're already registered! Sign in below"
    end
    isArtist = input[:isArtist].to_i
    # @user = (isArtist == 1) ? Artist.new(input.except(:fullAccountCreate)) : User.new(input.except(:fullAccountCreate, :username))
    @user = User.new(input.except(:fullAccountCreate, :artistname))

    should_save = true
    first_name = input[:fname]
    if (first_name) && is_profane_name?(first_name)
      @user.errors.add(:fname, "Not valid")
      logger.debug "Profane first name"
      should_save = false
    end
    last_name = input[:lname]
    if (last_name) && is_profane_name?(last_name)
      @user.errors.add(:lname, "Not valid")
      logger.debug "Profane last name"
      should_save = false
    end
    email = input[:email].downcase
    if (email) && is_profane_name?(email)
      @user.errors.add(:email, "Not valid")
      logger.debug "Profane email"
      should_save = false
    end
    if fullAccountCreate > 0
      password = input[:password]
      if password.length < 6
        @user.errors.add(:password, "Too short")
        should_save = false
      end
    end

    # TODO: check for artist name duplicates

    # TODO: Show message if signing up with an email that already exists
    session[:new_user] = @user
    logger.debug "Session user: #{ session[:new_user] }"
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
          logger.debug "Found user for email: #{ email }"
          save_user_to_cookie(@user)
        end
      end
    end

    return @user.errors
  end
end
