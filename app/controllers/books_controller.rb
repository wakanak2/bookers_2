class BooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @books=Book.all
    @user=current_user
    
    if @book.save
       flash[:notice]="Book was successfully created."
       redirect_to book_path(@book)

     else
     render :index

    end
  end

  def show
    @book=Book.find(params[:id])
    @books=Book.all
    @user=current_user
  
    
    
  end

  def index
    @books=Book.all
    @user=current_user
    @book=Book.new
    

   

  end

  def edit
    @book=Book.find(params[:id])
  

    
  end

  def update
    @book=Book.find(params[:id])
    
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
       redirect_to book_path

    else

      render :edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end



  private 
  def book_params
    params.require(:book).permit(:title, :body )
  end
  def correct_user
    book = Book.find(params[:id])
    if current_user != book.user
      redirect_to books_path
    end
  end

end
