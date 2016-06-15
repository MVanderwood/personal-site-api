class V1::BlogsController < V1::ApplicationController

  #GET /api/v1/blogs
  def index
    @blogs = Blog.all.order(:updated_at)
  end
  #GET /api/v1/blogs/:id
  def show
    @blog = Blog.find_by(id: params[:id])
  end

  #POST /api/v1/blogs
  def create
    @blog = Blog.new(params[:blog].permit(:title, :content))
    unless @blog.save
      render json: @blog.errors, status: :unprocessible_entity
    end
  end

  #GET /api/v1/blogs/:id/edit
  def edit
    @blog = Blog.find_by(id: params[:id])
  end

  #PATCH /api/v1/blogs/:id
  def update
    @blog = Blog.find_by(id: params[:id])
    unless @blog.update(params[:blog].permit(:title, :content))
      render json: @blog.errors, status: :unprocessible_entity
    end
  end

  #DELETE /api/v1/blogs/:id
  def destroy
    @blog = Blog.find_by(id: params[:id])
    begin
      @blog.destroy
      render json: @blog, status: :ok
    rescue NoMethodError
      render json: nil, status: :not_found
    end
  end

end
