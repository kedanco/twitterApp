class UsersController < ApplicationController

  before_action :getUser

  def home
    @allTweets = []
      @following = Relationship.where(follower_id: @user.id).find_each do |rship|
          user = User.find(rship.followed_id)
          @allTweets << user.tweets.all.order("updated_at DESC")
      end
  end

  def index
    @others = User.where.not(id: current_user.id)
  end

  def show
    @tweets = @user.tweets.all.order("updated_at DESC")
    @avatar = @user.avatar
    

  end

  def update

    user_params = params[:user].permit(:avatar)
    user = User.find(current_user.id)


    if user.update(user_params)
      flash[:success] = "Image successfully added!"
      redirect_to user_path(user)
    else
      flash[:danger] = "There was an error adding your image!"
      render :show
    end
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
