class LoginController < ApplicationController
  include LoginHelper
  
  def destroy
    sign_out
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
end
