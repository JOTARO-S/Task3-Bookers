class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find_by(id: @books.user_id)
    
  end  
    
  def edit
      @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path(@book.id)
    else
      render("books/edit")
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  protected

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:introduction, :name, :profile_image, :user_id)
  end
  
  def is_matching_login_user
    user_id = Book.find(params[:id]).user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
  
end
