require 'rails_helper'

describe "Places" do

    location = 'Humppila'
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if more than one is returned by the API, those are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Pubi", id: 2 ) ]
      )
  
      visit places_path
      fill_in('city', with: 'kumpula')
      click_button "Search"
  
      expect(page).to have_content "Oljenkorsi"
      expect(page).to have_content "Pubi"
    end
    it "if there are no places, the info is correct" do
        allow(BeermappingApi).to receive(:places_in).with(location).and_return(
            [  ]
          )        
        visit places_path
        fill_in('city', with: location)
        click_button "Search"
        
        expect(page).to have_content "No locations in #{location}"
    end
end