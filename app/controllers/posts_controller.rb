class PostsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:new]
  def posts
    #@posts = current_user.posts.order(id: :desc).page(params[:page])
    @posts = Post.all.page(params[:page])
  end
  
  def new
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = current_user.posts.order(id: :desc).page(params[:page])
    end
  end
  
  def show
    @post = Post.find(params[:id])
    
    #user_idはただの割り当てられた数字（ID）にすぎないので、ユーザを特定する事は出来ない
    #その為、全てのユーザ（User.all）のIDと、postに含まれていたuser_idに一致するものがあるかeachとif文で特定する
    #その後@userに代入して、必要なviewsに送る
    @users = @post.user_id
    User.all.each do |user| 
      if user.id == @users
        @user = user
      end
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'posts/post'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
