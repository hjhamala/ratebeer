class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password


  validates :username, uniqueness: true,
            length: { minimum: 3,  maximum: 15 }

  has_many :ratings, dependent: :destroy   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy # käyttäjällä on monta ratingia
  has_many :beer_clubs, through: :memberships

  validates :password, :presence => true,
                        :confirmation => true,

                        :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{4,}\z/}


  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer

  end

  def favorite_style
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.joins(:beer).select("avg(score) as ave, beers.style as stl").group("stl").order("ave desc").first.stl
  end

  def favorite_brewery
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.joins('left outer join beers on beers.id = ratings.beer_id left outer join breweries on beers.brewery_id = breweries.id').select("breweries.name as nm, avg(score) as ave").group("nm").order("ave desc").first.nm

  end

end
