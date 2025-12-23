class PostsController < ApplicationController
  #before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_post, only: [:show, :destroy]
  before_action :authorize_user!, only: [:destroy]
  # GET /kurs/kurs-id/posts/post-id 
  def show
    begin
      @post = Post.find(params[:postID])
      # @user = User.find(@post.user_id)
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end

  # GET /kurs/id/new
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id, fach_id: params[:id]))


    respond_to do |format|
      if @post.save
        notify_followers(@post.fach)
        format.html { redirect_to show_post_path(@post.fach_id, @post.id), notice: "Notiz wurde erfolgreich erstellt" }
        format.json { render partial: "posts/post", locals: { post: @post }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:postID])
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path(@post.fach_id), status: :see_other, notice: "Notiz wurde erfolgreich gelöscht" }
      format.json { head :no_content }
    end
  end


  private
  def set_post
    begin
      @post = Post.find(params[:postID])
      #@user = User.find(@post.user_id)
    rescue ActiveRecord::RecordNotFound
      render_not_found
      end
  end

  def notify_followers(fach)
    fach.followers.each do |follower|
      FachMailer.notify_followers(follower, fach).deliver_later
    end
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to posts_path(@post.fach_id), alert: "You are not authorized to modify this post."
    end
  end
    # Only allow a list of trusted parameters through.
  def post_params
    #params.expect(post: [ :title, :content, :files, :likes, :fach_id])
    # fehler behoben - wenn man hier die :likes mit rein nimmt, dann funktioniert der Upload nicht mehr
    params.require(:post).permit(:title, :content, :fach_id, files: [])
  end
end
