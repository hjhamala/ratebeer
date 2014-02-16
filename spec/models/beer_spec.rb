require 'spec_helper'

describe Beer do



describe "with name and style set" do



  it "it is saved" do
    beer = FactoryGirl.create(:beer)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end

describe "with no name " do



  it "it is not saved" do
    a = FactoryGirl.create(:style)
    b = Beer.create style: a
    expect(b).not_to be_valid
    a.save

    expect(Beer.count).to eq(0)
  end
end

describe "with no style" do


  it "it is not saved" do
    a = FactoryGirl.create(:beer)
    a.style = nil
    expect(a).not_to be_valid

  end
end



end

