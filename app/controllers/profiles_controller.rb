class ProfilesController < ApplicationController
  
  #get request to //users/:user_id/profile/new
  def new
    #render blank profile details form
    @profile = Profile.new
  end   
end     