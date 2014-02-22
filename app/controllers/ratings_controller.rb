class RatingsController < ApplicationController
  before_action :ensure_that_admin, only: [:destroy]
  def index
  @ratings = Rating.all
  @ratings_recent = Rating.recent.take(5)
  @breweries_top_3 = Brewery.top(3)
  @beers_top_3 = Beer.top(3)
  @styles_top_3 = Style.top(3)

  @users_top_3 = User.top_raters(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end