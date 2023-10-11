class Author < ApplicationRecord
  has_many :books

  def full_name
    "#{last_name} #{first_name}"
  end

end
