class Author < ApplicationRecord
  has_many :books

  def full_name
    "#{last_name} #{first_name}"
  end

  def age
    Date.today.year - date_of_birth.year
  end

end
