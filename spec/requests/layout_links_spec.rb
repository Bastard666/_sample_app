require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do

  describe "GET /" do
    it "should find home page at '/'" do
      get '/'
      expect(response).to have_http_status(200)
      assert_generates '/', controller: 'pages', action: 'home'
    end
  end

  describe "GET /contact" do
    it "should find contact page at '/contact" do
      get '/contact'
      expect(response).to have_http_status(200)
      assert_generates '/contact', controller: 'pages', action: 'contact'
    end
  end

  describe "GET /about" do
    it "should find about page at '/about'" do
      get '/about'
      expect(response).to have_http_status(200)
      assert_generates '/about', controller: 'pages', action: 'about'
    end
  end

  describe "GET /help" do
    it "should find help page at '/help" do
      get '/help'
      expect(response).to have_http_status(200)
      assert_generates '/help', controller: 'pages', action: 'help'
    end
  end

  describe "GET /signup" do
    it "should find help page at '/signup" do
      get '/signup'
      expect(response).to have_http_status(200)
      assert_generates '/signup', controller: 'users', action: 'new'
    end
  end
end
