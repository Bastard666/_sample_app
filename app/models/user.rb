# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#
# require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 50 }
                   
  validates :email, presence: true, 
                    format: { with: email_regex, message: "Invalid email format" },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 }
  
  before_save :encrypt_password

  def has_password?(submited_password)
    self.encrypted_password == encrypt(submited_password)
  end

  def self.authenticate(email, submitted_password)
    user = self.find_by_email(email)
    # another way >> user if user and user.has_password?(submitted_password)
    user && user.has_password?(submitted_password) ? user : nil
  end

  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt password
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
