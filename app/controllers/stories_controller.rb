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
      current_user.upvote_story(@story)
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
  
  
  def upvote_story
    @story.score += 1
    @story.save
    @story.user.karma += 1
    @story.user.save
    
    respond_to do |format|
      format.html { redirect_to @story }
      format.js
    end
  end
  
end
