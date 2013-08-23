module CommentsHelper
  def sanitize_comment_text(t)
    #return t
    t = sanitize t, tags: %w(p br), attributes: %w(id class style)
    return t.strip
  end

  def already_voted(user, comment)
    p user
    p comment
    Vote.exists?(user_id: user.id, comment_id: comment.id)
  end

end
