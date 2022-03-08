class Favorite < ApplicationRecord

  validates:book_id,presence:true,uniquness:{scope:user_id}   #ログインしてuser_idを保有する。１投稿(bookdetail)に対していいねを１回だけuserはできるので一意性はuser_idのみを制限。
  belongs_to:user
  belongs_to:book


end
