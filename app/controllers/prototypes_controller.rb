class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def show
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      return redirect_to root_path, alert: "プロトタイプが見つかりませんでした。"
    end
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'プロトタイプが作成されました！'
    else
      render :new
    end
  end

  def edit
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      return redirect_to root_path, alert: "プロトタイプが見つかりませんでした。"
    end
  end

  def update
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      return redirect_to root_path, alert: "プロトタイプが見つかりませんでした。"
    end

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプが更新されました！'
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      return redirect_to root_path, alert: "プロトタイプが見つかりませんでした。"
    end

    if @prototype.destroy
      redirect_to root_path, notice: 'プロトタイプを削除しました！'
    else
      redirect_to prototype_path(@prototype), alert: '削除に失敗しました。'
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      Rails.logger.error("Prototype with id=#{params[:id]} not found")
      return redirect_to root_path, alert: 'プロトタイプが見つかりませんでした。'
    end

    unless @prototype.user == current_user
      Rails.logger.error("User #{current_user.id} tried to access Prototype #{@prototype.id}, which they do not own.")
      redirect_to root_path, alert: '権限がありません。'
    end
  end
end