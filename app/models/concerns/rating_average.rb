module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    average = ratings.map(&:score).inject(0, &:+) / ratings.count.to_f
    average
  end

  def round(number)
    ActionController::Base.helpers.number_with_precision(number, precision: 1)
  end
end
