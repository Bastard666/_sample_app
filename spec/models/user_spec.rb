# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com", :password => "password", :password_confirmation => "password" }
  end

  it "should create a new valid instance" do
    User.create!(@attr)
  end

  describe "name validations" do
    it "should require a name" do
      bad_guy = User.new(@attr.merge(:name => ""))
      expect(bad_guy).to_not be_valid
    end

    it "should reject names too long" do
      long_name = "a" * 51
      long_name_user = User.new(@attr.merge(:name => long_name))
      expect(long_name_user).to_not be_valid
    end
  end

  describe "email validations" do
    it "should require an email" do
      user_without_email = User.new(@attr.merge(:email => ""))
      expect(user_without_email).to_not be_valid
    end

    it "should accept a valid email" do
      emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      emails.each do |email|
        user_with_valid_email = User.new(@attr.merge(:email => email))
        expect(user_with_valid_email).to be_valid
      end
    end

    it "should reject an invalid email" do
      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      invalid_emails.each do |invalid_email|
        user_with_invalid_email = User.new(@attr.merge(:email => invalid_email))
        expect(user_with_invalid_email).to_not be_valid
      end
    end

    it "should reject a duplicate email" do
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr.merge(:name => "New User"))
      expect(user_with_duplicate_email).to_not be_valid
    end

    it "should reject a duplicate email with a different case" do
      upcase_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcase_email))
      user_with_duplicate_email = User.new(@attr)
      expect(user_with_duplicate_email).to_not be_valid
    end
  end

  describe "password validations" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should require a password" do
      user_without_password = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      expect(user_without_password).to_not be_valid
    end

    it "should have the a confirmed password" do
      user_without_password_confirmation = User.new(@attr.merge(:password_confirmation => "different_password"))
      expect(user_without_password_confirmation).to_not be_valid
    end

    it "should reject a (too) short password" do
      short = "a" * 5
      user_without_password_confirmation = User.new(@attr.merge(:password => short, :password_confirmation => short))
      expect(user_without_password_confirmation).to_not be_valid
    end

    it "should reject a (too) long password" do
      long = "a" * 41
      user_without_password_confirmation = User.new(@attr.merge(:password => long, :password_confirmation => long))
      expect(user_without_password_confirmation).to_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an attribute encrypted_password" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "should have an encrypted password" do
      expect(@user.encrypted_password).to_not be_blank
    end

    it "should be true if the encrypted password corresponds" do
      expect(@user.has_password? @attr[:password]).to be true
    end

    it "should be false if the encrypted password does not correspond" do
      expect(@user.has_password? "invalid").to be false
    end
  end

  describe "user authentication" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should return nil if the user does not exist" do
      expect(User.authenticate("unknown_user@foo.com", @attr[:password])).to be nil
    end

    it "should return nil if the password is wrong" do
      expect(User.authenticate(@attr[:email], "wrong_password")).to be nil
    end

    it "should return the user if the password is right" do
      expect(User.authenticate(@attr[:email], @attr[:password])).to eq @user
    end
  end

end
