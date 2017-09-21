class CommentsController < ApplicationController

  before_action :find_tweet
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def create
      @comment = @tweet.comments.create(params[:comment].permit(:content))
      @comment.user_id = current_user.id
      @comment.save

      if @comment.save
        redirect_to tweet_path(@tweet)
      else
        render 'new'
      end
  end

    def destroy
      @comment.destroy
      redirect_to tweet_path(@tweet)
    end

  def edit

  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to tweet_path(@tweet)
    else
      render 'edit'
    end
  end



  private

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end


  #def find_post
  #  @pos = Poster.find(params[:poster_id])
  #end

  def find_comment
    @comment = @tweet.comments.find(params[:id]) 
  end

  def comment_owner
    unless current_user.id == @comment.user_id
        flash[:notice] = "access denied"
        redirect_to @tweet
      end
    end
end
