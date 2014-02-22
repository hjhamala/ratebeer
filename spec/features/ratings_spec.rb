require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "when ratings are created, show them in list" do
    FactoryGirl.create :rating, beer: beer1, user: user

    visit ratings_path

    expect(page).to have_content 'iso 3 10 by Pekka'
    expect(page).to have_content 'Ratings count: 1'



  end

  it "when ratings are created, show them in list" do
    user2 = FactoryGirl.create :user2
    FactoryGirl.create :rating, beer: beer1, user: user
    FactoryGirl.create :rating, beer: beer2, user: user2

    visit user_path(user)
    expect(page).to have_content 'iso 3 10'
    expect(page).not_to have_content 'Karhu'
    expect(page).to have_content 'Has 1 rating'



  end

  it "when ratings are deleted, do it if admin" do

    FactoryGirl.create :rating, beer: beer1, user: user

    visit user_path(user)

    expect(page).to have_content 'iso 3 10'
    expect(page).not_to have_content 'Karhu'
    expect(page).to have_content 'Has 1 rating'
    u = User.first
    u.update_attribute(:admin, true)
    expect{find_link("delete").click}.to change{Rating.count}.from(1).to(0)

  end


end