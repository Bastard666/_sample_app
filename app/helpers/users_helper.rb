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

module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_image_tag user.email, :alt => user.name,
                                  :class => 'gravatar', 
                                  :gravatar => options
  end
end
