# == Schema Information
# Schema version: 20110421160303
#
# Table name: locations
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  latitude    :string(255)
#  longitude   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Location < ActiveRecord::Base
  attr_accessible :title, :description, :latitude, :longitude
  
  belongs_to :user
  
  validates :title,         :presence => true, 
                            :length => { :within => 4..160 }
  validates :description,   :presence => true, 
                            :length => { :minimum => 4 }
  validates :latitude,      :presence => true
  validates :longitude,     :presence => true
  
  default_scope :order => 'locations.created_at DESC'
end
