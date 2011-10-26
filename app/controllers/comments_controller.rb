class CommentsController < ApplicationController

  #-------------------------------------------------
  # Setup
  #-------------------------------------------------

  load_and_authorize_resource :story
  load_and_authorize_resource :comment, :through  => :story
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def new
  end


  def create
    
    @story = Story.find(params[:story_id])
    
    @comment         = @story.comments.build(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to(@comment.story)
    else
      flash[:notice] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.story)
    end

  end
  
  
  def edit
  end


  def update 
  end

  def show
  end
  
end
