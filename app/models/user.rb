# == Schema Information
# Schema version: 20110420205315
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  surname            :string(255)
#  email              :string(255)
#  gender             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#  home_latitude      :string(255)
#  home_longitude     :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :surname, :email, :gender, :password, :password_confirmation, :home_latitude, :home_longitude
  
  has_many :locations, :dependent => :destroy
  
  before_save :encrypt_password
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,      :presence     => true,
                        :length       => { :within => 3..50 }
  validates :surname,   :presence     => true,
                        :length       => { :within => 3..50 }                    
  validates :gender,    :presence     => true
  validates :email,     :presence     => true,
                        :format       => { :with => email_regex },
                        :uniqueness   => { :case_sensitive => false }
  validates :password,  :presence     => true,
                        :confirmation => true,
                        :length       => { :within => 5..40 }
                        
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
  end
  
  def feed
    Location.where("user_id = ?", id)
  end

  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
