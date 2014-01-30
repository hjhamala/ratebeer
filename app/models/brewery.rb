class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers


  validates :name, length: { minimum: 1 }
  validate :year_cannot_be_in_future

  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: 2014,
                                    only_integer: true }
  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def year_cannot_be_in_future

    unless self.year.nil?
        return self.year <= Time.now.year
    end
  end

end
