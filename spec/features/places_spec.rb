require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    # click_button "Search"

    # expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are shown at the page" do

    stub_return = [Place.new(:name => "Oljenkorsi"), Place.new(:name => "Ohrantähkä")]
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        stub_return
    )

    visit places_path
    fill_in('city', with: 'kumpula')

    #click_button "Search"

    #expect(page).to have_content "Oljenkorsi"
    #expect(page).to have_content "Ohrantähkä"
  end

  it "if none is found then none is shown" do

    stub_return = []
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        stub_return
    )

    visit places_path
    #fill_in('city', with: 'kumpula')
    #click_button "Search"

    #expect(page).to have_content "No locations in kumpula city"

  end
end