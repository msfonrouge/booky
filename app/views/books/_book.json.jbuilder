json.extract! book, :id, :title, :isbn, :date_of_publication, :review, :price, :author_id, :publisher_id, :created_at, :updated_at
json.url book_url(book, format: :json)
