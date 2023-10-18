class AuthorsController < ApplicationController
 before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  def index
    @authors = Author.page(params[:page])

    # Initialize session variables if they are not set
    session[:query] ||= nil

    # Retrieve filter and search parameters from the session
    session[:query] = params[:query] if params[:query].present?

    # Filter by birth year
    if params[:date_of_birth].present?
      year = params[:date_of_birth].to_i
      start_date = Date.new(year, 1, 1)
      end_date = Date.new(year, 12, 31)
      @authors = @authors.where(date_of_birth: start_date..end_date)
    end

    # Filter by nationality
     if params[:nationality].present?
        @authors = Author.where(nationality: params[:nationality]).page(params[:page])
      end

      # Filter by author search
    if session[:query].present?
      sql_subquery = "first_name ILIKE :query OR last_name ILIKE :query"
      @authors = @authors.where(sql_subquery, query: "%#{session[:query]}%")
    else
      session[:query] = nil
    end
  end

  def clear
    session.delete(:query)
    redirect_to authors_path
  end

  # GET /authors/1
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  def destroy
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully deleted." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:first_name, :last_name, :date_of_birth, :about, :nationality)
    end

end
