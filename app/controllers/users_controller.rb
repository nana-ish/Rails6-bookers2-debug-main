class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user=current_user
    @book=Book.new
    @users = User.all
    @books=Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def destroy
   user= User.find(params[:id])
   user.destroy
   redirect_to books_path
  end

  def followeds
    @user = User.find(params[:id])
    @users = @user.followeds
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

#ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
    end
  end


end
