class StaticPagesController < ApplicationController
  def home
    @recently_reviewed_books = Book.recently_reviewed
  end
end
