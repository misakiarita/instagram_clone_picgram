class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)

  end

  def create
    @blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else

      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end


# def confirm
#   @blog = current_user.blogs.build(blog_params)
#   render :new if @blog.invalid?
#   # @blog = Blog.new(blog_params)
#   # render :new if @blog.invalid?
# end

  private

    def blog_params
      params.require(:blog).permit(:title, :content)
    end
  end