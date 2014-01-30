class BeerClub < ActiveRecord::Base

  has_many :memberships # käyttäjällä on monta ratingia
  has_many :members, through: :memberships, source: :user

end
