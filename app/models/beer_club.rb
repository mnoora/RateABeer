class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  def user_not_member?(user)
    is = true
    users.each do |u|
      if user == u
        is = false
      end
    end
    is
  end
end
