class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user
  scope :confirmed, -> (beer_club_id){ where confirmed: true
                                      where "beer_club_id = ? and confirmed = ?", beer_club_id, true }
  scope :unconfirmed, -> (beer_club_id){ where confirmed: true
                                        where "beer_club_id = ? and (confirmed = ? or confirmed is ?)", beer_club_id, false,nil}
  scope :confirmed_user, -> (user_id){ where confirmed: true
                                       where "user_id = ? and confirmed = ?", user_id, true }
  scope :unconfirmed_user, -> (user_id){ where confirmed: true
                                         where "user_id = ? and (confirmed = ? or confirmed is ?)", user_id, false,nil}

  validates_uniqueness_of :beer_club, :scope => :user

end
