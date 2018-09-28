require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username:"Ismo" }

  before :each do
    sign_in(username:"Pekka",password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3 Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:15)

    expect{
      click_button("Create Rating")
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "ratings are shown on the ratings page" do
    FactoryBot.create :rating, beer_id:1, score:2, user:user
    FactoryBot.create :rating, beer_id:1, score:6, user:user

    visit ratings_path

    expect(page).to have_content "iso 3 2 Pekka"
    expect(page).to have_content "iso 3 6 Pekka"
    expect(page).to have_content "Number of ratings 2"
  end

  it "user's ratings are shown on the user's page" do
    FactoryBot.create :rating, beer_id:1, score:2, user:user
    FactoryBot.create :rating, beer_id:2, score:6, user:user
    FactoryBot.create :rating, beer_id:1, score:10, user:user2
    visit user_path(user)

    expect(page).to have_content "iso 3 2 delete"
    expect(page).to have_content "Karhu 6 delete"
    expect(page).not_to have_content "iso 3 10 delete"
    expect(page).to have_content "Has made 2 ratings, average 4.0"
  end

  it "user can delete his/her rating" do
    FactoryBot.create :rating, beer_id:1, score:2, user:user
    visit user_path(user)
    expect(user.ratings.count).to eq(1)
    page.all("a")[9].click
    expect(user.ratings.count).to eq(0)
  end
end