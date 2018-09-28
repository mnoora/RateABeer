class User < ApplicationRecord
  include RatingAverage

  PASSWORD_FORMAT = /\A
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
/x

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..30 }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :password, length: { minimum: 4 },
                       format: { with: PASSWORD_FORMAT }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    #return nil if ratings.empty?
    #beers.sort_by { |e| counter[e.style] }
  end
end
