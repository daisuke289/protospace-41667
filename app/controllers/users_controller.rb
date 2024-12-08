class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # URLから取得したidを使い、対象ユーザーを検索
    @prototypes = @user.prototypes # ユーザーが投稿したプロトタイプを取得
  end
end