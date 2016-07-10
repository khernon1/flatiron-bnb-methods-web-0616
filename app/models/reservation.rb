class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  
  belongs_to :host, :class_name => "User", :foreign_key => 'listing_id'
  
  validate :open_listing?
  validate :date_check
  validate :same_person
  validates_presence_of :checkin, :checkout

  def date_check
    unless self.checkin.present? && self.checkout.present? && self.checkin < self.checkout
      add_errors
    end
  end

  def same_person
    unless self.listing_id != self.guest_id
      add_errors
    end
  end

  def open_listing?    
    Reservation.all.each do |reservation|
      if reservation.id != self.id
        stay = (reservation.checkin..reservation.checkout).to_a
        add_errors if stay.include?(self.checkin) || stay.include?(self.checkout) 
      end
    end
  end

  def add_errors
    self.errors.add(:base, "Something is wrong with the reservation")
  end

  def duration
    self.checkout - self.checkin
  end

  def total_price
    duration * listing.price.to_s('F').to_i
  end

end
