class ProfilesController < ApplicationController
  
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
      redirect_to user_path( params[:user_id])
    else
      render action: :new
    end  
  end 
  
  #Must whitelist for security reasons 
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end  
end     