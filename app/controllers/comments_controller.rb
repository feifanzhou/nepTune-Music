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
    @user = current_user
    @comments = Comment.where(commentable_type: type, commentable_id: id, comment_id: nil)
    @comments = Comment.sort_comments(@comments)
  end

  def update
    cu = current_user
    if cu.blank?
      return
    end
    comment = Comment.find(params[:id])
    vote = Vote.where(comment_id: comment.id, user_id: cu.id).take(1)[0]
    changed = false
    if vote

    else
      # Prevent users from hacking JS to set upvotes to any value
      # Only increment upvotes by 1, as long as upvotes param is 'true'
      if params[:upvotes].to_i >= 1
        Vote.create(comment_id: comment.id, user_id: cu.id, is_upvote: true)
        comment.upvotes_total += 1
        changed = true
      end
      comment.save
    end

    render json: { changed: changed }

  end

end
