class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  validates :name, length: { minimum: 1 }
  validate :year_cannot_be_in_future

  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: 2014,
                                    only_integer: true }
  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def to_s
    "#{self.name}"
  end

  def year_cannot_be_in_future

    unless self.year.nil?
        return self.year <= Time.now.year
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n)
  end

end
