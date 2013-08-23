module CommentsHelper
  def sanitize_comment_text(t)
    #return t
    t = sanitize t, tags: %w(p br), attributes: %w(id class style)
    return t.strip
  end
end
