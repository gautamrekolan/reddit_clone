class StoriesController < ApplicationController

  #-------------------------------------------------
  # Setup
  #-------------------------------------------------

  load_and_authorize_resource
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def index    
    @stories = Story.order("created_at DESC").accessible_by(current_ability, :read).all
  end


  def show

  end


  def new
  end


  def create
    @story.user = current_user
    if @story.save
      flash[:notice] = "Story was successfully created."
      redirect_to(@story)
    else
      flash[:notice] = "There were errors with your story submissions."
      render :action => "new"
    end
  end
  
  
  def edit
  end


  def update
    if @story.save
      flash[:notice] = "Story was successfully updated."
      redirect_to(stories_url)
    else
      flash[:notice] = "There were errors with your story submissions."
      render :action => "edit"
    end  
  end


  def destroy
    @story.destroy
    
    flash[:notice] = "The story was deleted successfully."
    redirect_to(stories_url)
  end
  
  
end
