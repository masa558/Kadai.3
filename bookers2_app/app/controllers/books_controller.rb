class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id) #アクションを経由して、ページに遷移する(変数を自動的に渡る)
    else
      @books = Book.all
      @user = current_user
      render :index #アクションを経由せずに、ページに遷移する(変数の定義が必要)
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy
    redirect_to books_path
  end

  def edit
    book = Book.find(params[:id])
    unless book.user == current_user
    redirect_to books_path
    end
    
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    unless book.user == current_user
    redirect_to books_path
    end
    
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
