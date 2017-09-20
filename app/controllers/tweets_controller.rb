class TweetsController < ApplicationController

  def home

  end

  def index
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = Comment.where(tweet_id: @tweet).order("created_at DESC")
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

  end

  def update

  end

  def destroy

  end





end
