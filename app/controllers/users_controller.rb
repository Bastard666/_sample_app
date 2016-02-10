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

class UsersController < ApplicationController
  def new
    @title = 'Inscription'
  end

  def create
    User.create(params[:user])
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permits(:name, :email)
    end
end
