class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery

  USERNAME, PASSWORD = "lainuo", "h123456"

  def post_slug(post)
    date_array = post.created_at.to_time.to_formatted_s(:db).split(' ').first.split('-')
    "/" + date_array.join("/") + "/" + post.id.to_s + "-" + post.slug #title.parameterize
  end

  def article_slug(article)
    date_array = article.created_at.to_time.to_formatted_s(:db).split(' ').first.split('-')
    "/" + date_array.join("/") + "/" + article.slug #title.parameterize
  end

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:l]
  end
end
