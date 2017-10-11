class SearchController < ApplicationController
  def index
    redirect_to(root_path, alert: "Keyword can't be blank") if params[:keyword].blank?
    keyword = params[:keyword]
    search_by = params[:search_by]
    case search_by
    when "Title"
      @books = Book.search_by_title keyword
    when "Author"
      @books = Book.search_by_author keyword
    when "Public Year"
      @books = Book.search_by_public_year keyword
    end
  end
end
