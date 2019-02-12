class UsersController < ApplicationController
  
  #when GET request is made to /users/:id
  def show 
    @user = User.find( params[:id] )
  end   
end    