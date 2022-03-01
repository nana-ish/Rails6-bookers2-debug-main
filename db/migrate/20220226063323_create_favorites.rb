class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      #追加したカラム
      t.integer :user_id    #どのユーザがいいねを押したか
      t.integer :book_id    #どの本の投稿にいいねを押したか

      t.timestamps
    end
  end
end
