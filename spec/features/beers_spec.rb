require 'spec_helper'

include OwnTestHelper

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    FactoryGirl.create :brewery
    sign_in(username:"Pekka", password:"Foobar1")
  end



  describe "User who has signed up" do
    it "can create beers" do

      visit new_beer_path

      fill_in('beer[name]', with:'Koff')

      expect{
        click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)
    end

    it "cannot create beers with empty names" do
      visit new_beer_path




      click_button "Create Beer"

      expect(Beer.count).to eq(0)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'Name is too short'
    end

    it "helper for classes" do


      BeerClub
      BeerClubsController
      Membership
      MembershipsController
      Brewery
      BreweriesController



    end

  end




end