class BookCommentsController < ApplicationController


  def create
    @bookdetail=Book.find(params[:book_id])                                                 #model名.find(取得したいレコードのid)　特定のbook_idのレコードを取得（今回は本の投稿者の情報が欲しい）
    @book_comment = BookComment.new(book_comment_params)                                    #book_commentに空のラベルを１列作り、@book_commentとして定義(フォームから送られてきたデータを取得)
    @book_comment.user_id = current_user.id                                                 #current_user.id(ログインしてる人)を投稿した人の.user_idカラムに代入
    @book_comment.book_id = @bookdetail.id                                                  #@book.idの情報を@book_comment.book_idに入れる。
    @book_comment.save                                                                      #@book_commentを保存する。
    @book_comment = BookComment.new                                                         #@book_commentを投稿した後フォームには空のレコードをを入れることにより初期化する
    @book_comments = @bookdetail.book_comments                                              #コメント一覧のところで使う変数を格納　bookdetailに紐付いたbook_comment
  end

  def destroy
    bookdetail = Book.find(params[:book_id])                                                 #destroy.jsで使う変数
    @book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])          #＠book_commentは削除する値の変数
    @book_comment.destroy
    @book_comments = bookdetail.book_comments                                                #特定の本に紐付いたbook_commentを全て持ってきて@book_commentsに格納
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:book_comment)
  end


end
