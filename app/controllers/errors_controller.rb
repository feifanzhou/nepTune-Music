class ErrorsController < ApplicationController
  def not_found
    render file: "public/404.html", status: :not_found
  end

  def server_error
  end

  def unprocessable
  end

  def access_denied
  end
end
