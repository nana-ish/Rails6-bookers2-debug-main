class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

 # ====================フォローしているユーザーとの関連 ================================================================================================================
  #フォローする側から見た 、フォローされる側のUserを(中間テーブルを介して)集める。なので親（捕まえる側）はfollower_id(フォローする側)にあたる。この親を　foreign_key　とする。
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #userが中間テーブル（relationships）を介して、follower(relationsship.rbで定義したuserモデルをもとにした仮想モデル)の情報を持ってくる。
  #sourceは何を基準にデータを持ってくるかであるため、自分がフォローしている人(followed)が基準になる。has_many :followedsの1単位
  has_many :followeds, through: :active_relationships, source: :followed


# =====================フォローされるユーザーとの関連 ===================================================================================================================
  #フォローされた側から見たアソシエーション、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollowed_id(フォローされる側)
  has_many :passsive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #userが中間テーブル（relationships）を介して、followerの情報(relationsship.rbで定義したuserモデルをもとにした仮想モデル)を持ってくる
  has_many :followers, through: :passsive_relationships, source: :follower


  has_one_attached :profile_image

  validates :name, length: { minimum:2, maximum:20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
   unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def followed_by?(user)
    # (引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passsive_relationships.find_by(follower_id: user.id).present?
  end

   def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
   end

end
