require 'spec_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "beers are ordered by the name", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    find('table').find('tr:nth-child(2)').should have_content('Fastenbier')
    find('table').find('tr:nth-child(3)').should have_content('Lechte Weisse')
  end

  it "beers can be ordered by the style", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    click_link('Style')
    find('table').find('tr:nth-child(2)').should have_content('Lager')
    find('table').find('tr:nth-child(3)').should have_content('Rauchbier')
  end

  it "beers are ordered by the brewery", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    click_link('Brewery')
    find('table').find('tr:nth-child(2)')
    find('table').find('tr:nth-child(2)').should have_content('Ayinger')
    find('table').find('tr:nth-child(3)').should have_content('Koff')
  end
end