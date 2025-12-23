class FachbereichController < ApplicationController
  before_action :set_fachbereich, only: %i[ index ]

  def index
    @ownerBildungseinrichtung = Bildungseinrichtung.find(@currentFachbereich.bildungseinrichtung_id)
    @owningStudiengänge = Studiengang.where(fachbereich_id: @currentFachbereich.id)
  end

  private
    def set_fachbereich
      @currentFachbereich = Fachbereich.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found()
    end
end
