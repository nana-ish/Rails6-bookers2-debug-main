class BookComment < ApplicationRecord

  validates:user_id,presence:true
  belongs_to:user
  belongs_to:book

  validates :book_comment, presence:true

end
