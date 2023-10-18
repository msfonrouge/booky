class AuthorsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

    def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

    def update
    respond_to do |format| 
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

    def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
