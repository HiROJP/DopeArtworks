class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  #https://qiita.com/chobi9999/items/2b59fdaf3dd8f2ed9268 なぜ必要なのかは←を参考に
  protect_from_forgery :except => [:create, :destroy]
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = 'お気に入り登録をしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end