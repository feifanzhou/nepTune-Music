class UsersController < ApplicationController
  include ApplicationHelper
  include LoginHelper
  include UsersHelper

  def self.user=(u)
    @user = u
  end
  def self.user
    @user
  end

  def show
  end

  def new
  end

  def save_user_to_cookie(a_user)
    if !(a_user.has_temp_password)
      cookies[:current_user] = { value: a_user.remember_token, expires: 20.years.from_now }
    else
      cookies[:new_user] = { value: a_user.id, expires: 20.years.from_now }
    end
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

  def create
    sign_out
    errors = create_user(params)

    if @user.errors.blank?
      redirect_back
    else
      render template: "login/login"
    end
  end

  def make_beta_tester
    current_user = User.find_by_id(cookies[:new_user])
    current_user.willingToBetaTest = true
    current_user.save
    redirect_back
  end
end
