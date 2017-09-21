class UsersController < ApplicationController

  before_action :getUser

  def home
  end

  def index
  end

  def show
    @tweets = @user.tweets.all
  end

  private

  def getUser
    if params[:id] == nil
      @user = User.find(current_user.id)
    else
      @user = User.find(params[:id])
    end
  end

end
