module BooksHelper
  def rate_value value
    @book.reviews.count_rate value
  end
end
