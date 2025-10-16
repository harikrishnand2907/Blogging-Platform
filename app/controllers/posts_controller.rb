class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :download_pdf]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  require 'csv'
  require 'prawn'

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  def import
    if params[:file].present?
      CSV.foreach(params[:file].path, headers: true) do |row|
        current_user.posts.create(title: row['title'], content: row['content'])
      end
      redirect_to posts_path, notice: 'Posts imported successfully.'
    else
      redirect_to posts_path, alert: 'Please select a CSV file.'
    end
  end

  def download_pdf
    pdf = Prawn::Document.new
    pdf.text @post.title, size: 24, style: :bold
    pdf.move_down 10
    pdf.text @post.content
    send_data pdf.render, filename: "#{@post.title}.pdf", type: 'application/pdf', disposition: 'attachment'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_path, alert: 'Not authorized!' unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
