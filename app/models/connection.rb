# == Schema Information
# Schema version: 20110424145324
#
# Table name: connections
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  contact_id  :integer
#  status      :integer
#  accepted_at :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Connection < ActiveRecord::Base      
  
  belongs_to :user
  belongs_to :contact, :class_name => "User", :foreign_key => "contact_id"
  validates_presence_of :user_id, :contact_id
  
  #Status codes
  ACCEPTED = 0
  REQUESTED = 1
  PENDING = 2   
  
  def accept
    Connection.accept(user_id, contact_id)
  end
  
  def breakup
    Connection.breakup(user_id, contact_id)
  end
 
  class << self        
    
    def exists?(user, contact)
      not conn(user, contact).nil?
    end
    
    alias exist? exists?
    
    def request(user, contact)
      if user == contact or Connection.exists?(user, contact)
        nil
      else
        transaction do
          create(:user => user, :contact => contact, :status => PENDING)  
          create(:user => contact, :contact => user, :status => REQUESTED)
        end
        true
      end
    end        
    
    def accept(user, contact)
      transaction do
        accepted_at = Time.now
        accept_one_side(user, contact, accepted_at)
        accept_one_side(contact, user, accepted_at)
      end
    end       
    
    def connect(user, contact)
      transaction do
        request(user, contact)
        accept(user, contact)
      end
      conn(user, contact)
    end       
    
    def breakup(user, contact)
      transaction do
        destroy(conn(user, contact))
        destroy(conn(contact, user))
      end
    end
    
    def conn(user, contact)
      find_by_user_id_and_contact_id(user, contact)
    end    
    
    def accepted?(user, contact)
      conn(user, contact).status == ACCEPTED
    end

    def connected?(user, contact)
      exist?(user, contact) and accepted?(user, contact)
    end
    
  end  
  
  private
  
  class << self
    
    def accept_one_side(user, contact, accepted_at)
      conn = conn(user, contact)
      conn.update_attributes!(:status => ACCEPTED, :accepted_at => accepted_at)
    end
      
  end
 
end
