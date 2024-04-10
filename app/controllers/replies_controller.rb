class RepliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @reply = current_user.replies.build(reply_params)
    @reply.micropost = @micropost
    @reply.image.attach(params[:reply][:image])
    if @reply.save
      flash[:success] = "Reply sent!"
      redirect_to @micropost
    else
      render 'microposts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost = @reply.micropost
    @reply.destroy
    flash[:success] = "Reply deleted"
    if request.referrer.nil?
      redirect_to @micropost, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

    def reply_params
      params.require(:reply).permit(:content, :image)
    end

    def correct_user
      @reply = current_user.replies.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @reply.nil?
    end
end
