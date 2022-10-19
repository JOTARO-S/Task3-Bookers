class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    @userId = current_user.id
    
  end
  
  def create
    book = Book.new(
      book_params,
    user_id: @current_user.id)
    if book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(book.id)
    else
      @books = Book.all
      render :books_path
    end
  end

  def show
    @books = User.find_by(id: @book.user_id)
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to books_path
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
      redirect_to books_path
    end
  end
  
end
