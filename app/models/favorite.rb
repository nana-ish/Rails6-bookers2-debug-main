class Favorite < ApplicationRecord

  validates:user_id,presence:true,uniquness:{scope:book_id}   #ログインしてuser_idを保有する。１投稿(bookdetail)に対していいねを１回だけuserはできるので一意性はbook_idのみを制限。
  belongs_to:user
  belongs_to:book

 
end
