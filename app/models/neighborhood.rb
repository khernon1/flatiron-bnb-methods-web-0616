class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(checkin, checkout)
    self.listings
  end

  def self.highest_ratio_res_to_listings
    neigh_hash = Reservation.all.joins(listing: :neighborhood).group('neighborhoods.name').count
    listing_hash = Listing.all.joins(:neighborhood).group('neighborhoods.name').count

    hash = {}
    neigh_hash.map do |k,v|
      hash[k] = (v.to_f/listing_hash[k].to_f).to_f  
    end
    #binding.pry
    Neighborhood.all.find_by(name: hash.key(hash.values.max))      
  end

  def self.most_res
    neigh_hash = Reservation.all.joins(listing: :neighborhood).group('neighborhoods.name').count
#    binding.pry
    Neighborhood.all.find_by(name: neigh_hash.key(neigh_hash.values.max))         
  end


end
