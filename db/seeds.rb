# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



User.create(email: 'user1@example.com', password: '123456', admin: true)
User.create(email: 'user2@example.com', password: '123456', admin: false)


70.times do
  author = Author.create(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    date_of_birth: Faker::Date.between(from: 100.year.ago, to: 20.year.ago),
    about: Faker::Lorem.sentence,
    nationality: Faker::Address.country
  )
end

15.times do
  publisher = Publisher.create(name: Faker::Book.publisher)
end

150.times do
  book = Book.create(
    title: Faker::Book.unique.title,
    isbn: Faker::Code.unique.isbn,
    date_of_publication: Faker::Date.between(from: '1960-01-01', to: Date.today),
    review: Faker::Lorem.paragraph,
    price: Faker::Number.decimal(l_digits: 2),
    author: Author.find(rand(1..Author.count)),
    publisher: Publisher.find(rand(1..Publisher.count))
  )
end
