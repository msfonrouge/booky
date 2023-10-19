class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  acts_as_favoritable
end
