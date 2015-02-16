require 'faker'
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @key = Faker::Internet.password(6)
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    key = params[:key]
    post = Post.where(id: params[:id], hidden_key: params[:key])
    if post.empty?
      redirect_to @post, notice: "Use the following format:  /posts/#{@post.id}/edit?key='key' (replace quotes respectively)"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    params["post"]["hidden_key"] = Faker::Internet.password(6)
    @post = Post.new(post_params)
    if @post.category == ""
      render :new, notice: "Category required"
    elsif @post.category == nil
      render :new, notice: "Please select a category"
    elsif @post.save
      redirect_to @post, notice: "Edit url is /posts/#{@post.id}/edit?key=#{@post.hidden_key}"
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @category = Category.find(@post.category_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :description, :contact, :comission, :category_id, :hidden_key)
    end
end
