class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  #get request to //users/:user_id/profile/new
  def new
    #render blank profile details form
    @profile = Profile.new
  end   
  
  # This is for POST request/users/:user_id/profile
  def create
  # Ensure that we have the user who is filling out form  
    @user = User.find( params[:user_id] )
  # Create profile linked to this specific user  
    @profile = @user.build_profile( profile_params)
    if @profile.save
      flash[:success] = "Profie is updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action: :new
    end  
  end 
  
  #Get request /users/:user_id/profile/edit
  def edit 
    @user = User.find( params[:user_id])
    @profile = @user.profile
  end   
  
  # PUT/PATCH request to  /users/:id/profile
  def update
    #retrieve the user from database
    @user = User.find( params[:user_id] )
    #retrieve that users profile
    @profile = @user.profile 
    #Mass assign edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      #redirect user to thei profile page
      redirect_to user_path(id: params[:user_id])
    else 
      render action: :edit
    end   
  end   
  
  #Must whitelist for security reasons 
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end  
    
    def only_current_user
      @user = User.find( params[:user_id])
      redirect_to(root_url) unless @user == current_user
    end   
end     