class TweetsController < ApplicationController

  def home

  end

  def index
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.order("created_at DESC")
    @comment = Comment.new
    
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet_params = params[:tweet].permit(:text,:user_id)
    user = User.find(tweet_params[:user_id])
    @tweet = user.tweets.new(tweet_params)
    if @tweet.save
      flash[:success] = "Tweet successfully created!"
      redirect_to user_path(user.id)
    else
      flash[:danger] = "There was an error saving your tweet."
      render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet_params = params[:tweet].permit(:text,:user_id)
    user = User.find(tweet_params[:user_id])
    @tweet = Tweet.find(params[:id])

      if @tweet.update(tweet_params)
      flash[:success] = "Tweet successfully updated!"
      redirect_to user_path(user.id)
    else
      flash[:danger] = "There was an error saving your tweet."
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    user = User.find(@tweet.user_id)
    @tweet.destroy
    flash[:success] = "Tweet deleted!"
    redirect_to user_path(user)
  end

end
