class StartController < ApplicationController
  def index
    @most_followed_courses = Fach.left_joins(:follows).group(:id).order('COUNT(follows.id) DESC').limit(3)
    @postsmostrecent = Post.order(created_at: :desc)
    @postsmostlikes = Post.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC, posts.created_at DESC')
    if user_signed_in?
      @following_ids = Follow.where(user_id: current_user.id).pluck(:fach_id)
      @followedKurse = Fach.where(id: @following_ids)
      if params[:sort] == 'liked'
        @posts = Post.where(fach_id: @following_ids).left_joins(:likes).group(:id).order('COUNT(likes.id) DESC, posts.created_at DESC')
        @notesmessage = "Beliebteste Notizen aus gefolgten Kursen"
      else
        @posts = Post.where(fach_id: @following_ids).order(created_at: :desc)
        @notesmessage = "Neueste Notizen aus gefolgten Kursen"
      end
    end
  end
end
