class BildungseinrichtungController < ApplicationController
  before_action :set_bildungseinrichtung, only: %i[ index ]
  def index
    @zugehörigeFachbereiche = Fachbereich.where(bildungseinrichtung_id: @currentBildungseinrichtung.id)
  end

  private
    def set_bildungseinrichtung
      @currentBildungseinrichtung = Bildungseinrichtung.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found()
    end
end
