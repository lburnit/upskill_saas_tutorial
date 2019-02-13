class UsersController < ApplicationController
  before_action :authenticate_user!
  
  #when GET request is made to /users/:id
  def show 
    @user = User.find( params[:id] )
  end   
end    