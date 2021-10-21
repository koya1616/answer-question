class LikesController < ApplicationController
  prepend_before_action :set_likeable, only: :create
  before_action :authenticate_user!

  def create
    @likeable.liked_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end    
  end

  def destroy
    like = current_user.likes.find(params[:id])
    @likeable = like.likeable
    @likeable.unliked_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end    
  end
end
