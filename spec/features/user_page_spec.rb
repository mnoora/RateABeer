require 'rails_helper'

include Helpers

describe "User" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryBot.create :brewery, name:"Brew Dog" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", style: "Lager", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Nanny state",style:"lowalcohol", brewery:brewery2 }
  let!(:user) { FactoryBot.create :user }

  describe "Favorite style" do
    before :each do
      user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
      sign_in(username:"Pekka",password:"Foobar1")
    end

    it "if no ratings there should also not be favorite style" do
      visit user_path(user)

      expect(page).not_to have_content "Favorite beer style:"
    end

    it "if only one rating the favorite style is the style of rated beer" do
      FactoryBot.create :rating, beer_id:2, score:2, user:user
      visit user_path(user)

      expect(page).to have_content "Favorite beer style: lowalcohol"
    end

    it "shows right favorite style of beer on the user's page" do
      FactoryBot.create :rating, beer_id:1, score:2, user:user
      FactoryBot.create :rating, beer_id:2, score:6, user:user
      FactoryBot.create :rating, beer_id:1, score:10, user:user

      visit user_path(user)

      expect(page).to have_content "Favorite beer style: Lager"
    end
  end
  describe "Favorite brewery" do
    before :each do
      user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
      sign_in(username:"Pekka",password:"Foobar1")
    end

    it "if no ratings there should also not be favorite brewery" do
      visit user_path(user)

      expect(page).not_to have_content "Favorite brewery:"
    end

    it "if only one rating the favorite style is the style of rated beer" do
      FactoryBot.create :rating, beer_id:2, score:2, user:user
      visit user_path(user)

      expect(page).to have_content "Favorite brewery: Brew Dog"
    end

    it "shows right favorite style of beer on the user's page" do
      FactoryBot.create :rating, beer_id:1, score:2, user:user
      FactoryBot.create :rating, beer_id:2, score:6, user:user
      FactoryBot.create :rating, beer_id:1, score:10, user:user

      visit user_path(user)

      expect(page).to have_content "Favorite brewery: Koff"
    end
  end
end