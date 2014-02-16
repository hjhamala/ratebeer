class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }
  validates :style, presence: true





  def to_s
    "#{self.name} (#{self.brewery.name})"
  end

  private

  def validate_style_id
    sdgöldsölsddfsgö
    s = Style.find_by id: :style_id
    return !s.nil?


  end

end
