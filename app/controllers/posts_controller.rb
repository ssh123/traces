class PostsController < ApplicationController
  uses_tiny_mce
  before_filter :authenticate, :except => [:index, :show, :show_redirect, :show_all]
  
  def index
    @recent_posts = Post.recent
    @posts = Post.order("created_at desc")
    @tags = Term.tags
  end
  
  def show
    #@recent_posts = Post.recent
    @post = Post.where("id = ?", params[:id].to_i)
    redirect_to post_slug(@post.first)
    #@tags = Term.tags
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  
  def show_redirect
    @post = Post.where("id = ?", params[:title].to_i)
    redirect_to post_slug(@post.first)
  end
  
  def show_all
    @recent_posts = Post.recent
    @tags = Term.tags
    parse_time
    
    unless params[:title].nil?
      @post = Post.where("id = ? AND created_at BETWEEN ? AND ?", params[:title].to_i, @begin_time, @end_time)
    else
      @posts = Post.where("created_at BETWEEN ? AND ?", @begin_time, @end_time)
    end
    
    unless @post.nil?
      @comment = Comment.new
    end
    
    logger.debug Time.now
    logger.debug @post
  end
  
  private
  
  def parse_time

    if params[:month].nil?
      @begin_time = params[:year] + "-01-01"
      @end_time = (params[:year].to_i + 1).to_s + "-01-01"
    else
      @begin_time = params[:year] + "-" + params[:month]
      if (params[:month].to_i + 1 > 12)
        @end_time = (params[:year].to_i + 1).to_s + "-01"
      else
        if (params[:month].to_i + 1).to_s.length > 1
          @end_time = params[:year] + "-" + (params[:month].to_i + 1).to_s
        else
          @end_time = params[:year] + "-0" + (params[:month].to_i + 1).to_s
        end
      end

      if params[:day].nil?
        @begin_time += "-01"
        @end_time += "-01"
      else
        @begin_time = @begin_time + "-" + params[:day]
        @end_time = @begin_time.to_date.next.to_s
      end
    end

    logger.debug @begin_time
    logger.debug @end_time   
  end
  
end