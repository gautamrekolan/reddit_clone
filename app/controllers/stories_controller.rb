class StoriesController < ApplicationController

  #-------------------------------------------------
  # Setup
  #-------------------------------------------------

  load_and_authorize_resource
    
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def index    
    @stories = Story.order("created_at DESC").accessible_by(current_ability, :read).limit(20)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def newest    
    @stories = Story.newest.accessible_by(current_ability, :read).limit(20)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def top    
    @stories = Story.top.accessible_by(current_ability, :read).limit(20)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  

  def show

  end


  def new
    logger.debug "new"
  end


  def create
    @story.user = current_user    
    if @story.save
      flash[:notice] = "Story was successfully created."
      current_user.vote_on_story @story, :up
      redirect_to(@story)
    else
      flash[:notice] = "There were errors with your story submissions."
      render :action => "new"
    end
  end
  
  
  def edit
  end


  def update
    @story.attributes = params[:story]
    if @story.save
      flash[:notice] = "Story was successfully updated."
      redirect_to(@story)
    else
      flash[:notice] = "There were errors with your story submissions."
      render :action => "edit"
    end  
  end


  def destroy
    @story.destroy
    
    flash[:notice] = "The story was deleted successfully."
    redirect_to(stories_path)
  end
  
  
  def upvote
    current_user.vote_on_story @story, :up
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def downvote
    current_user.vote_on_story @story, :down
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  
end
