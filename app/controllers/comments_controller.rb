class CommentsController < ApplicationController
  include LoginHelper
  def create
    opts = params[:comment]
    c = Comment.new(opts)
    c.user = current_user
    c.save
    #redirect_to :back
  end

  def by_type_id
    type = params[:type]
    id = params[:id]
    @comments = Comment.where(commentable_type: type, commentable_id: id)
    @comments = Comment.sort_comments(@comments)
  end

end
