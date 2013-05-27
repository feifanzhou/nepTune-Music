class ApplicationController < ActionController::Base
  protect_from_forgery
  
  if Rails.env.production?
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionController::UnknownController, with: :render_404
      rescue_from ActionController::UnknownAction, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
    end
  end
  
  def render_404(exception)
    render file: "public/404.html", status: :not_found
  end
  
  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    render file: "public/500.html", status: :internal_server_error
  end
end
