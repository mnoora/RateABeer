require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved when it has all parameters" do
    brewery = Brewery.create name:"panimo", year:"2018"
    beer = Beer.create name:"Olut", style:"Lager", brewery:brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
  it "is not saved when there is no name" do
    brewery = Brewery.create name:"panimo", year:"2018"
    beer = Beer.create name:"", style:"Lager", brewery:brewery
    beer.errors[:name].should include("can't be blank") # check for presence of error
    expect(Beer.count).to eq(0)
  end

  it "is not saved when there is no style" do
    brewery = Brewery.create name:"panimo", year:"2018"
    beer = Beer.create name:"Olut", brewery:brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
