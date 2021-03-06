class BackboneController < ApplicationController
  #layout nil
  layout :determine_layout
  def index
    #ua = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)"
    #ua = "Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 9.0; en-US)"
    #ua = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    if is_IE_below_9?
      @is_ie_9 = true
      render :file => "#{Rails.root}/public/browsers.html", :layout => false
    end

    if is_googlebot?
      @articles = Article.by_published_at :descending => true, :limit => 5
      respond_to do |format|
        format.html
        format.json { render json: @articles}
      end
    end
  end

  def signed_in_check
    if user_signed_in?
      render :json => current_user, :status => 200
    else
      render :json => "Unauthorized", :status => 401
    end
  end

  private
  def is_googlebot?
    ua = request.user_agent
    #ua = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

    return false if ua.nil?
    return false unless ua.downcase.index('googlebot')

    true
  end

  def is_IE_below_9?
    ua = request.user_agent
    #ua = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)"

    return false if ua.nil?
    if ua.downcase.index('msie')
      return false if ua.downcase.index('msie 9')
      return true
    end
  end

  def determine_layout
    if is_googlebot?
      "articles"
    else
      "backbone"
    end
  end
end