class UsersController < ApplicationController

  #-------------------------------------------------
  # Setup
  #-------------------------------------------------

  load_and_authorize_resource
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def new
  end


  def create
    if @user.save
      @user.role = "user"
      @user.save!
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      flash[:notice] = "There were errors with your user submissions."
      render :action => "new"
    end
  end
  
  
  def edit
  end


  def update
    if @user.save
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      flash[:notice] = "There were errors with your user submissions."
      render :action => "edit"
    end  
  end

  
end
