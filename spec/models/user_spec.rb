require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with too small password" do
    let(:user){ User.create username:"Pekka", password:"sec", password_confirmation:"sec" }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe "with password with only characters" do
    let(:user){ User.create username:"Pekka", password:"Security", password_confirmation:"Security" }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end



  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end

  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is lager if only one created" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style.name).to eq("lager")
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      beer = FactoryGirl.create(:beer2)
      FactoryGirl.create(:rating, score:30, beer:beer, user:user)

      expect(user.favorite_style.name).to eq("lager")
    end

  end


  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is anonymous if only one created" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery.name).to eq("anonymous")
    end

    it "is the one with highest rating average if several rated" do
      create_beer_with_rating(10, user)
      create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)
      brewery = FactoryGirl.create(:brewery2)
      beer = FactoryGirl.create(:beer2, brewery: brewery)
      FactoryGirl.create(:rating, score:30, beer:beer, user:user)

      expect(user.favorite_brewery.name).to eq("toinen")
    end

  end


end