class UsersController < ApplicationController
  include ApplicationHelper
  include LoginHelper
  include UsersHelper

  before_filter :signed_in_user, only: [:update, :upload]
  before_filter :authenticate_editing, only: [:show]

  def self.user=(u)
    @user = u
  end
  def self.user
    @user
  end

  def show
    @user = User.find_by_id(params[:id])
    @media_shared = Song.all
  end

  def new
  end

  def edit
  end

  def authenticate_editing
    @is_editing = false
    if params[:edit] == '0'
      redirect_to_current_page_without_params
      return
    end
    @can_edit = can_edit()
    @is_editing = true if @can_edit && params[:edit].to_i == 1

    if !@is_editing
      redirect_to_current_page_without_params if !params[:edit].blank?
    end
  end


  def create
    sign_out
    params[:password] = temporary_password
    params[:has_temp_password] = true
    # errors = create_user(params)
    results = create_user(params)

    puts "create user results: #{ results }"
    # if @user.errors.blank?
    if results.errors.blank?
      puts 'redirecting back'
      redirect_back
    else
      #render template: "login/login"
    end
  end

  def make_beta_tester
    current_user = User.find_by_id(cookies[:new_user])
    current_user.willingToBetaTest = true
    current_user.save
    redirect_back
  end

  def upload
    #signed_in_user
  end

  def update
    #signed_in_user
    if @user
      @user.update_attributes(params[:user])
      puts @user.nice_messages # in case it fails

      save_user_to_cookie(@user)
      redirect_to upload_path
    end
  end

  def signed_in_user
    @user = User.find_by_remember_token(cookies[:current_user])
    if not @user
      redirect_to login_path
    end
  end
end
