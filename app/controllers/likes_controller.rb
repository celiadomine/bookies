class LikesController < ApplicationController
  # only logged in user can like
  before_action :authenticate_user! 

  def create
    @likeable = find_likeable
    
    # to avaid duplicate likes
    unless current_user.likes.exists?(likeable: @likeable)
      current_user.likes.create!(likeable: @likeable)
    end
    
    redirect_back fallback_location: root_path, notice: "Post or review liked!"
  end

  def destroy
    @likeable = find_likeable
    
    like = current_user.likes.find_by(likeable: @likeable)
    like.destroy if like
    
    redirect_back fallback_location: root_path, notice: "Post or review unliked."
  end

  private

  # Diese Methode findet heraus, ob es sich um einen Post oder ein Review handelt
  def find_likeable
    if params[:review_id]
      Review.find(params[:review_id])
    elsif params[:post_id]
      Post.find(params[:post_id])
    else
      # Dies sollte bei korrekten Routen nicht passieren
      raise ActiveRecord::RecordNotFound, "Likeable resource not specified"
    end
  end
end