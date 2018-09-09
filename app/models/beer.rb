class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        mean = ratings.map(&:score).inject(0, &:+)
        mean/ratings.count
    end
end
