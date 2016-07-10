class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  def city_openings(checkin, checkout)
    self.listings
  end

  def self.highest_ratio_res_to_listings
    city_hash = Reservation.all.joins({listing: {neighborhood: :city}}).group('cities.name').count
    listing_hash = Listing.all.joins(neighborhood: :city).group('cities.name').count
    
    hash = {}
    city_hash.map do |k,v|
      hash[k] = (v.to_f/listing_hash[k].to_f).to_f  
    end  
    
    City.all.find_by(name: hash.key(hash.values.max))    
  end

  def self.most_res
    city_hash = Reservation.all.joins({listing: {neighborhood: :city}}).group('cities.name').count
    #binding.pry
    City.all.find_by(name: city_hash.key(city_hash.values.max))
  end

end

