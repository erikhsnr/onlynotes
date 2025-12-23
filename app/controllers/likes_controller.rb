class LikesController < ApplicationController
  before_action :find_post

  def create
    unless user_signed_in?
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post-#{@post.id}-like-button", partial: "likes/redirect_to_sign_in") }
        format.html { redirect_to new_user_session_path, alert: "Du musst angemeldet sein, um eine Notiz zu liken" }
      end
      return
    end
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to request.referer || posts_path(@post), notice: "Like removed" }
        format.json { render json: { status: 'unliked' } }
      end
    else
      @post.likes.create(user: current_user)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to request.referer || posts_path(@post), notice: "Liked" }
        format.json { render json: { status: 'liked' } }
      end
    end
  end

  def destroy
    if not user_signed_in?
      redirect_to new_user_session_path, alert: "Du musst angemeldet sein, um eine Notiz zu liken"
    else
      like = @post.likes.find_by(user: current_user)
      if like
        like.destroy
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to request.referer || posts_path(@post), notice: "Like removed" }
          format.json { render json: { status: 'unliked' } }
        end
      else
        @post.likes.create(user: current_user)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to request.referer || posts_path(@post), notice: "Liked" }
          format.json { render json: { status: 'liked' } }
        end
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
