class User < ActiveRecord::Base
#host
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :guests, :class_name => "User", :through => :reservations  

#guest
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :hosts, :class_name => "User", :through => :trips  

  has_many :reviews, :foreign_key => 'guest_id'
  has_many :host_reviews, :foreign_key => 'reservation_id', :class_name => "Review"


#used in listing spec
  def self.change_host_status(host)
    host.toggle(:host)
    host.save
  end

end