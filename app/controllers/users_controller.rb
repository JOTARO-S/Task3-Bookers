class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
    
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render("users/edit")
      end
  end
  
  protected

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
  params.require(:user).permit(:introduction, :name, :profile_image)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end

  
end
