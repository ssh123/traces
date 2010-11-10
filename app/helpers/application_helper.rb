module ApplicationHelper
  
  def post_slug(post)
    date_array = post.created_at.to_time.to_formatted_s(:db).split(' ').first.split('-')
    root_url + date_array.join("/") + "/" + post.id.to_s + "-" + post.slug #title.parameterize
  end
end
