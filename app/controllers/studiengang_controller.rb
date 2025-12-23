class StudiengangController < ApplicationController
  before_action :set_studiengang, only: %i[ index ]

  def index
    @ownerFachbereich = Fachbereich.find(@currentStudiengang.fachbereich_id)
    @ownerBildungseinrichtung = Bildungseinrichtung.find(@ownerFachbereich.bildungseinrichtung_id)
    @owningKurse = Fach.where(studiengang_id: @currentStudiengang.id)
  end

  private
    def set_studiengang
      @currentStudiengang = Studiengang.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found()
    end
end
