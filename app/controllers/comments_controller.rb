class CommentsController < ApplicationController
  include LoginHelper
  def create
    opts = params[:comment]
    c = Comment.new(opts)
    c.user = current_user
    c.save
    redirect_back
  end
end
