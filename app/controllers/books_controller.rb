class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :accept_request]
  before_action :get_categories, only: [:new, :create, :edit, :update]
  before_action :require_permission, only: [:edit, :update, :destroy]

  def index
    @books = Book.accepted
  end

  def show
    @reviews = @book.reviews
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if params[:book][:category_ids]
      params[:book][:category_ids].each do |id|
        @book.categories << Category.find_by(id)
      end
    end

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept_request
    if @book.update(book_params)
      redirect_to(book_requests_path, notice: "Book request accepted")
    else
      redirect_to(book_requests_path, alert: "Failed")
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_categories
      @categories = Category.all
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :public_year, :user_id, :pending,
        :cover, :cover_cache, :remove_cover, category_ids: [])
    end

    def require_permission
      if current_user.regular_user? && current_user.id != @book.user.id
        redirect_to(root_path, alert: "Unauthorized access")
      end
    end
end
