class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
    #追加したカラム
      t.integer :user_id    #どのユーザがいいねを押したか
      t.integer :book_id    #どの本の投稿にいいねを押したか
      t.text:book_comment  #コメントを投稿するフォームにつかう

      t.timestamps
    end
  end
end
