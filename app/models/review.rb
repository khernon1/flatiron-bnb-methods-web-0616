class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  belongs_to :host, :class_name => "User"


  validates_presence_of :description, :rating
  validate  :had_reservation?

  def had_reservation?
    if self.reservation == nil || self.reservation.checkout >= Date.today
      #binding.pry
      self.errors.add(:base, "Missing reservation")
    end
  end

#used in listing class
  def self.average_review_rating(reviews)
    reviews.average(:rating).to_s('F').to_f
  end


end
