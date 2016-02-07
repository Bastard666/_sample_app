class PagesController < ApplicationController
  # Controller for home page
  def home
  	@title = 'Accueil'
  end

  # Controller for contact page
  def contact
  	@title = 'Contact'
  end

  # Controller for about page
  def about
  	@title = 'A propos'
  end

  # Controller for help page
  def help
  	@title = 'Aide'
  end
end
