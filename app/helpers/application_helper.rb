module ApplicationHelper
  def redirect_back
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def not_found
  	raise ActionController::RoutingError.new('Not Found')
  end
end
