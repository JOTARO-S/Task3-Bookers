class UsersController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    @userId = current_user.id
    @users = User.all
    
  end
  
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(book.id)
    else
      @books = Book.all
      render :books_path
    end
  end

  def show
    @userId = current_user.id
    @user = User.find(params[:id])
    
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)  
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
  params.require(:user).permit(:body, :name, :profile_image)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
  
end
