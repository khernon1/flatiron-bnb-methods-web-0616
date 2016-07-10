class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"  
  has_many :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  has_many :reviews, :through => :reservations
  
  validates_presence_of :address, :listing_type, :title, :description, :price, :neighborhood  
  

  after_create do  
      User.change_host_status(self.host)
  end

  after_destroy do
    if self.host.listings == [] && self.host.host == true      
     User.change_host_status(self.host) 
    end  
  end

  def average_review_rating
    Review.average_review_rating(self.reviews)
  end

end
