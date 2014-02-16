class PlacesController < ApplicationController
  def index
  end

  def search
    if params[:city].empty?
      redirect_to places_path, notice: "Empty search"
      return
    end


    @places = BeermappingApi.places_in(params[:city])
    # session[:last_city_search] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @places = BeermappingApi.places_in(session[:last_city_search])
    @place = @places.select {|place| place.id == params[:id]}.first

  end
end