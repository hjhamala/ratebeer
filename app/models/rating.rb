class Rating < ActiveRecord::Base
  belongs_to :beer, touch: true
  belongs_to :user   # rating kuuluu myös käyttäjään


  scope :recent, -> { limit 5
                      order(created_at: :desc)}


  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
      "#{beer.name} #{score}"
  end

end
