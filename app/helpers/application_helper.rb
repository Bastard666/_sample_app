module ApplicationHelper
	# Return the logo of the home page
	def logo
		image_tag("logo.png", :alt => "Application Exemple", :class => "round")
	end
	
	# Return the title of the page
	def title
		base_titre = "Simple App du Tutoriel Ruby on Rails"
		@title.nil? ? base_titre : "#{base_titre} | #{@title}"
	end
end
