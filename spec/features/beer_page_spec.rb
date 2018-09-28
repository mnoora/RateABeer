require 'rails_helper'


describe "Beers page" do
    before :each do
        sign_in(username:"Pekka",password:"Foobar1")
    end
  it "should create beer with right parameters" do
    FactoryBot.create(:brewery, name: "Koff", year: 2018)
    visit new_beer_path
    fill_in('beer[name]', with:'olut')
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
        click_button('Create Beer')
      }.to change{Beer.count}.from(0).to(1)

    expect(Beer.count).to eq(1)
  end

  it "should not create beer invalid name" do
    FactoryBot.create(:brewery, name: "Koff", year: 2018)
    visit new_beer_path
    fill_in('beer[name]', with:'')
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    click_button('Create Beer')
    expect(page).to have_content "Name can't be blank"

    expect(Beer.count).to eq(0)
  end

end