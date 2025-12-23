class FachController < ApplicationController
  before_action :set_fach, only: %i[ index ]

  def index
    @followers = Follow.where(fach_id: @currentFach.id)
    @posts = Post.where(Fach_id: @currentFach.id).order(created_at: :desc)
    #@users = User.find(@posts.user_id)
    @currentStudiengang = Studiengang.find(@currentFach.studiengang_id)
    @currentFachbereich = Fachbereich.find(@currentStudiengang.fachbereich_id)
    @currentBildungseinrichtung = Bildungseinrichtung.find(@currentFachbereich.bildungseinrichtung_id)
  end

  def following
    if not user_signed_in?
      redirect_to new_user_session_path, alert: "Du musst angemeldet sein, um einem Kurs zu folgen"
    else
      @follow = Follow.find_or_initialize_by(user_id: current_user.id, fach_id: params[:id])
      if @follow.new_record?
        if @follow.save
          redirect_to posts_path(params[:id]), notice: "Du folgst jetzt diesem Kurs"
        else
          redirect_to posts_path(params[:id]), alert: "Fehler: Kurs konnte nicht gefolgt werden"
        end
      else
        @follow.destroy!
        redirect_to posts_path(params[:id]), notice: "Du bist dem Kurs entfolgt"
      end
    end
  end

  private
    def set_fach
      @currentFach = Fach.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end


end
