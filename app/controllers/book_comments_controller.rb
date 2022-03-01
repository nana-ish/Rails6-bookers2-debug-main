class BookCommentsController < ApplicationController


  def create
    @book=Book.find(params[:book_id])                           #model名.find(取得したいレコードのid)　特定のbook_idのレコードを取得（今回は本の投稿者の情報が欲しい）
    @book_comment = BookComment.new(book_comment_params)        #book_commentに空のラベルを１列作り、@book_commentに定義
    @book_comment.user_id = current_user.id                     #current_user.id(ログインしてる人)を投稿した人の.user_idカラムに代入
    @book_comment.book_id = @book.id                            #@book.id（本）の情報を@book_comment.book_idに入れる。
    @book_comment.save                                          #保存する。
    redirect_to book_path(@book), notice: "You have created comment successfully."
      # else
      #     @bookdetail = @book_comment.find(params[:book_id])
      #     redirect_to book_path(@bookdetail)
  end

  def destroy
   @book=Book.find(params[:book_id])
   @book_comment = BookComment.find(params[:id])
   @book_comment.destroy
   redirect_to book_path(@book), notice: "You have destroyed comment successfully."
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:book_comment)
  end


end
