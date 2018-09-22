module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.map(&:score).inject(0, &:+) / ratings.count.to_f
  end
end
