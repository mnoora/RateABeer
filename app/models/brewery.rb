class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :year, presence: true
  validate :year_is_integer,
           :year_is_not_before_1040,
           :year_is_not_in_future
  validates :name, presence: true
 

  def year_is_integer
    if !year.is_a? Integer
      errors.add(:year, "must be an integer")
    end
  end

  def year_is_not_before_1040
    if year.present? && year < 1040
      errors.add(:year, "must not be before year 1040")
    end
  end

  def year_is_not_in_future
    if year.present? && year > Time.now.year
      errors.add(:year, "must not be in the future")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
