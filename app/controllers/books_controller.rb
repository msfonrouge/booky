class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all
    #session[:query] ||= params[:query]
    #session[:filter] = params[:filter]
    #params[:filter_option] = nil if params[:filter_option] == ""
    #session[:filter_option] = params[:filter_option]

    # Initialize session variables if they are not set
    session[:query] ||= nil
    session[:date_of_publication] ||= nil
    session[:publisher] ||= nil

    # Retrieve filter and search parameters from the session
    session[:query] = params[:query] if params[:query].present?
    session[:date_of_publication] = params[:date_of_publication] if params[:date_of_publication].present?
    session[:publisher] = params[:publisher] if params[:publisher].present?

    # Filter by title
    if session[:query].present?  #session[:query]
      @books = @books.where("title ILIKE ?", "%#{params[:query]}%")
    end

    # Filter by publication year
    if session[:date_of_publication].present?
      year = session[:date_of_publication].to_i
      start_date = Date.new(year, 1, 1)
      end_date = Date.new(year, 12, 31)
      @books = @books.where(date_of_publication: start_date..end_date)
    end

    # Filter by author
    # if params[:author_id].present?
    #  author = Author.find(params[:author_id])
    #  books = author.books
    #  @books = @books & books
    #  # & is the intersection operator
    #  # https://ruby-doc.org/core-2.6.3/Array.html#method-i-26
    #  # https://en.wikipedia.org/wiki/Intersection_(set_theory)
    #


    # Filter by publisher
     if session[:publisher].present?
        publisher = Publisher.find(session[:publisher])
        @books = publisher.books
      end
    #list
    #initialize_search
    #handle_search_name
    #handle_filters
  end

  # GET /books/1 or /books/1.json
  def show
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
