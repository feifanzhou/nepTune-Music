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

  def create
    sign_out
    params[:password] = temporary_password
    params[:has_temp_password] = true
    # errors = create_user(params)
    results = create_user(params)

    # if @user.errors.blank?
    if results or results.blank?
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
