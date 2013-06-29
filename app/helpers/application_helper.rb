module ApplicationHelper
  def redirect_back
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def redirect_to_current_page_without_params
  	redirect_to request.fullpath.split("?")[0]  # http://stackoverflow.com/a/5266133/472768
  end

  def not_found
  	raise ActionController::RoutingError.new('Not Found')
  end
end
