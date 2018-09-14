module RatingAverage
    extend ActiveSupport::Concern
   
    def average_rating
        mean = self.ratings.map(&:score).inject(0, &:+)
        mean.to_f/self.ratings.count.to_f
    end
   end