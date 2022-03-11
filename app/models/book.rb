class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  #ダイレクトメッセージ機能
  has_many :user_room
  has_many :chats
  has_many :room, through: :user_room

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

 def favorited_by?(user)
    #favoritesモデルの中からuser.idの存在を確認して、1か０かを返す。
    favorites.where(user_id: user.id).exists?
 end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
