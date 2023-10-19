class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  acts_as_favoritable
  validates :title, :isbn, :date_of_publication, presence: true
end
