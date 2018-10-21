module TopObjects
    extend ActiveSupport::Concern

    def top(number)
        sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.average_rating || 0) }
        sorted_by_rating_in_desc_order.take(number)
    end
end 
