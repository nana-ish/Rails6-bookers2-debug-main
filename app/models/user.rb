class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

 # ====================自分がフォローしているユーザーとの関連 =========================================================================
  #フォローする側から見た 、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローする側)foreign_key:1側
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #userが中間テーブル（relationships）を介して、follower(relationsship.rbで定義したuserモデルをもとにした仮想モデル)の情報を持ってくる。sourceは has_many :followedsの実際の情報
  has_many :followeds, through: :active_relationships, source: :followed


# =====================自分がフォローされるユーザーとの関連 ===============================================================================
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


end
