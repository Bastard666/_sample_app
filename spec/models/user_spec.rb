# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
  end

  it "should create a new valid instance" do
    User.create!(@attr)
  end

  it "should require a name" do
    bad_guy = User.new(@attr.merge(:name => ""))
    expect(bad_guy).to_not be_valid
  end

  it "should reject names too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    expect(long_name_user).to_not be_valid
  end

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
