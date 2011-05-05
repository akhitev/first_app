class AppreciationsController < ApplicationController
  before_filter :authenticate

  def create
    @micropost = Micropost.find_by_id(params[:appreciation][:liked_id])
    current_user.like!(@micropost)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @micropost = Appreciation.find(params[:id]).liked
    current_user.unlike!(@micropost)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
