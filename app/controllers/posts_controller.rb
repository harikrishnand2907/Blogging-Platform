class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :download_pdf]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  require 'csv'
  require 'prawn'

def index
  @posts = Post.includes(:user, image_attachment: :blob).all
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
  @post = Post.find(params[:id])
  if @post.user == current_user
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  else
    redirect_to posts_path, alert: "You are not authorized."
  end
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
  pdf = Prawn::Document.new(page_size: 'A4')

  
  pdf.text @post.title, size: 22, style: :bold, align: :center
  pdf.move_down 20

 
  if @post.image.attached?
    image_path = ActiveStorage::Blob.service.send(:path_for, @post.image.key)
    pdf.image image_path, fit: [500, 300], position: :center
    pdf.move_down 20
  end

  
  pdf.text @post.content.to_s, size: 12, leading: 5, align: :justify
  pdf.move_down 30

 
  pdf.text "Posted by: #{@post.user.email}", size: 10, align: :left, style: :italic
  pdf.text "Generated on: #{Time.zone.now.strftime('%d %B %Y, %I:%M %p')}", size: 10, align: :right, style: :italic

  send_data pdf.render,
            filename: "#{@post.title.parameterize}.pdf",
            type: 'application/pdf',
            disposition: 'attachment'
end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_path, alert: 'Not authorized!' unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
