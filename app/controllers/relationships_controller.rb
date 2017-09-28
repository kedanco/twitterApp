class RelationshipsController < ApplicationController

  def create
    #@user = User.find(params[:user_id])

    #relationship_params = params[:Relationship]
    #user = User.find(relationship_params[:followed_id])
    #user = User.find_by(params[:followed_id])  find_by looks for a
    #hash and without 'id:' it looks for the 1st item in the hash
    user = User.find_by(id: params[:followed_id])
    #user = User.find_by(params[:id])
    current_user.follow(user)
    redirect_back(fallback_location: user_path(user))
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_back(fallback_location: user_path(user))
  end
end
