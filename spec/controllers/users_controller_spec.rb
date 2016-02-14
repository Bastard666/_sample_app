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

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get :new
      expect(response.body).to have_title('Inscription')
    end
  end

  describe "GET show" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      get :show, :id => @user
    end

    it "returns HTTP success" do
      expect(response).to have_http_status(:success)
    end

    it "should return the right user" do
      expect(assigns(:user)).to eq @user
    end

    it "should have the right title" do
      expect(response.body).to have_title(@user.name)
    end

    it "should have the name of the user" do
      expect(response).to have_selector("h1", :text => @user.name)
    end

    it "should have a profile image" do
      expect(response.body).to have_selector("h1>img.gravatar")
    end
  end

end
