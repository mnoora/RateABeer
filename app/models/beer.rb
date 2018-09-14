class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        mean = ratings.map(&:score).inject(0, &:+)
        mean/ratings.count
    end

    def to_s
        "#{name} #{brewery.name}"
    end
end
