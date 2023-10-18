class PublishersController < ApplicationController
before_action :set_publisher, only: %i[ show edit update destroy ]

  # GET /publishers or /publishers.json
  def index
    @publishers = Publisher.page(params[:page])

    # Initialize session variables if they are not set
    session[:query] ||= nil

    # Retrieve filter and search parameters from the session
    session[:query] = params[:query] if params[:query].present?

      # Filter by publisher search
    if session[:query].present?
      @publishers = @publishers.where("name ILIKE ?", "%#{session[:query]}%")
    else
      session[:query] = nil
    end
  end

  def clear
    session.delete(:query)
    redirect_to publishers_path
  end

  # GET /publishers/1
  def show
  end

  # GET /publishers/new
  def new
    @publisher = Publisher.new
  end

  # GET /publishers/1/edit
  def edit
  end

  # POST /publishers
  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to publisher_url(@publisher), notice: "Publisher was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publishers/1
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to publisher_url(@publisher), notice: "Publisher was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publishers/1
  def destroy
    @publisher.destroy

    respond_to do |format|
      format.html { redirect_to publishers_url, notice: "Publisher was successfully deleted." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publisher_params
      params.require(:publisher).permit(:first_name, :last_name, :date_of_birth, :about, :nationality)
    end

end
