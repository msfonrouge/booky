# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



User.create(email: 'user@example.com', password: '123456')


10.times do
  author = Author.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.between(from: 50.year.ago, to: 1.year.ago),
    about: Faker::Lorem.sentence,
    nationality: Faker::Address.country
  )
  publisher = Publisher.create(name: Faker::Book.publisher)
  book = Book.create(
    title: Faker::Book.title,
    isbn: Faker::Code.isbn,  # Generates a random ISBN
    date_of_publication: Faker::Date.between(from: 50.year.ago, to: 1.year.ago),
    review: Faker::Lorem.paragraph,
    price: Faker::Number.decimal(l_digits: 2),
    author: author,
    publisher: publisher
  )
end
