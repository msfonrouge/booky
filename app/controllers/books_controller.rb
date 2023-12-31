class BooksController < ApplicationController
  include Pundit
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :search]

  # GET /books or /books.json
  def index
    @books = Book.page(params[:page])
    authorize @books

    # Initialize session variables if they are not set
    session[:query] ||= nil

    # Retrieve filter and search parameters from the session
    session[:query] = params[:query] if params[:query].present?

    # Filter by publication year
    if params[:date_of_publication].present?
      year = params[:date_of_publication].to_i
      start_date = Date.new(year, 1, 1)
      end_date = Date.new(year, 12, 31)
      @books = @books.where(date_of_publication: start_date..end_date)
    end

    # Filter by publisher
     if params[:publisher].present?
        publisher = Publisher.find(params[:publisher])
        @books = publisher.books.page(params[:page])
      end

      # Filter by title or author search
    if session[:query].present?
      sql_subquery = "title ILIKE :query OR authors.first_name ILIKE :query OR authors.last_name ILIKE :query"
      @books = @books.joins(:author).where(sql_subquery, query: "%#{session[:query]}%")
    else
      session[:query] = nil
    end
      rescue Pundit::NotAuthorizedError
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
  end

  def clear
    session.delete(:query)
    redirect_to books_path
  end

  def search
    @books = Book.page(params[:page]).per(24)
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR authors.first_name ILIKE :query OR authors.last_name ILIKE :query"
      @books = @books.joins(:author).where(sql_subquery, query: "%#{params[:query]}%")
    else
      params[:query] = nil
  end
end

# Favorites, create controller?

def favorites
    @user = current_user
    @favorite_books = @user.all_favorites.page(params[:page])
end

  def add_to_favorites
    @book = Book.find(params[:id])
    current_user.favorite(@book)
    flash[:notice] = 'Book added to favorites successfully'
    redirect_to book_path(@book)
  end

  def remove_from_favorites
    @book = Book.find(params[:id])
    current_user.unfavorite(@book)
    flash[:notice] = 'Book removed from favorites successfully'
    redirect_to favorites_books_path
  end

  # GET /books/1 or /books/1.json
  def show
    @user = current_user
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :isbn, :date_of_publication, :review, :price, :author_id, :publisher_id)
    end

end
