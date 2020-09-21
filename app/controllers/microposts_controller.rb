class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'ライブを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ライブの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'ライブを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def new
     @micropost = current_user.microposts.build
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :livedatetime, :liveplace)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
  def favorites
    @micropost = current_user.microposts.find_by(id: params[:id])
    @favorites = @micropost.favorites.page(params[:page])
    counts(@micropost)
  end
end