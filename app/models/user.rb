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



end
