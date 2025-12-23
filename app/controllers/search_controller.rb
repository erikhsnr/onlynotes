class SearchController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  def index
    @search_term = params[:search_term]
    @search_type = params[:search_type] || 'kurs' #default kurs

    if @search_term.blank?                        #Standard Anzeige
      @results = case @search_type
      when 'kurs'
        Fach.all.limit(25)
      when 'dozent'
        Fach.all.limit(25)
      when 'studiengang'
        Studiengang.all.limit(25)
      when 'fachbereich'
        Fachbereich.all.limit(25)
      when 'bildungseinrichtung'
        Bildungseinrichtung.all.limit(25)
      else
        []
      end
    else
      @results = case @search_type
      when 'kurs'
        Fach.where('LOWER(name) LIKE ?', "%#{@search_term}%")
      when 'dozent'
        Fach.where('LOWER(dozenten) LIKE ?', "%#{@search_term}%")
      when 'studiengang'
        Studiengang.where('LOWER(name) LIKE ?', "%#{@search_term}%")
      when 'fachbereich'
        Fachbereich.where('LOWER(name) LIKE ?', "%#{@search_term}%")
      when 'bildungseinrichtung'
        Bildungseinrichtung.where('LOWER(name) LIKE ?', "%#{@search_term}%")
      else
        []
      end
    end
  end

  def new
    @newBildungseinrichtung = Bildungseinrichtung.new
    @newFachbereich = Fachbereich.new
    @newStudiengang = Studiengang.new
    @newFach = Fach.new
  end

  def create

    @newBildungseinrichtung = Bildungseinrichtung.find_or_initialize_by(name: params[:Eduname], ort: params[:ort])
    if !@newBildungseinrichtung.save
      flash.now[:alert] = "Fehler: Fehlende Parameter"
      render :new, status: :unprocessable_entity and return
    end
    @newFachbereich = Fachbereich.find_or_initialize_by(name: params[:FBname], bildungseinrichtung_id: @newBildungseinrichtung.id)
    if !@newFachbereich.save
      @newBildungseinrichtung.destroy
      flash.now[:alert] = "Fehler: Fehlende Parameter"
      render :new, status: :unprocessable_entity and return
    end
    @newStudiengang = Studiengang.find_or_initialize_by(name: params[:STname], fachbereich_id: @newFachbereich.id)
    if !@newStudiengang.save
      @newBildungseinrichtung.destroy
      @newFachbereich.destroy
      flash.now[:alert] = "Fehler: Fehlende Parameter"
      render :new, status: :unprocessable_entity and return
    end

    @newFach = Fach.find_or_initialize_by(name: params[:Fname], dozenten: params[:dozenten], studiengang_id: @newStudiengang.id)
    
    if @newFach.new_record?
      @newFach = Fach.new(name: params[:Fname], dozenten: params[:dozenten], studiengang_id: @newStudiengang.id, user_id: current_user.id)
      if @newFach.save
        redirect_to posts_path(@newFach.id), notice: "Neuer Kurs wurde erfolgreich erstellt"
      else
        @newBildungseinrichtung.destroy
        @newFachbereich.destroy
        @newStudiengang.destroy
        flash.now[:alert] = "Fehler: Fehlende Parameter"
        render :new, status: :unprocessable_entity and return
      end
    else
      redirect_to posts_path(@newFach.id), notice: "Diesen Kurs gibt es schon"
    end
  end

end
