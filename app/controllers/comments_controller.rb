class CommentsController < ApplicationController
  include LoginHelper
  def create
    opts = params[:comment]
    media_ids = params[:comment][:media_ids]
    c = Comment.new(opts.except(:media_ids))
    c.user = current_user
    if not media_ids
      media_ids = ""
    end
    media_ids.split(',').each do |i|
      c.media << Media.find(i)
    end
    c.save
    #redirect_to :back
  end

  def by_type_id
    type = params[:type]
    id = params[:id]
    @replyable = !current_user.blank?
    @comments = Comment.where(commentable_type: type, commentable_id: id, comment_id: nil)
    @comments = Comment.sort_comments(@comments)
  end

end
