require 'spec_helper'

describe Beer do



describe "with name and style set" do
  let(:beer){ Beer.create name:"Koff", style:"Lager"}

  it "it is saved" do
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end

describe "with no name " do
  let(:beer){ Beer.create style:"Lager"}

  it "it is not saved" do
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end

describe "with no style" do
  let(:beer){ Beer.create name:"Koff" }

  it "it is not saved" do
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end



end

