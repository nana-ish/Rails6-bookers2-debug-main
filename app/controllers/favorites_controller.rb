class FavoritesController < ApplicationController

  def create
    @bookdetail=Book.find(params[:book_id])                                                      #@booktailに特定のbook_idをもつレコード検索し格納。creteのアクションにはbook_idを引数として渡すように設定したから、paramの中身はbook_idが入る。
    @book_favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])           #@book_favoriteという空のレコードを用意。favoritesテーブルの型に沿って作成し、user_idにはログイン中のuser、book_idにはお気に入りしたい本のidが入る。
    @book_favorite.save
    # byebug
  end

  def destroy
    @bookdetail=Book.find(params[:book_id])                                                     #@booktailに特定のbook_idをもつレコード検索し格納。destroyのアクションもbook_idを引数として渡すように設定したから、paramの中身はbook_idが入る。
    @book_favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])      #user_idにログイン中のuser(user.id)が入り、特定のbook_idが入ったレコードを持ってきて@book_favvoriteに格納
    @book_favorite.destroy
  end

end