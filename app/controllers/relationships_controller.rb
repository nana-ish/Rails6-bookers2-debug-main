class RelationshipsController < ApplicationController


def create
 follower = current_user.active_relationships.build(followed_id: params[:user_id])       #カレントuserに紐付いたrelationshipsの空のレコードを用意。”follower_id"のカラムには引数で、user_idのパラメータを入れる
 # binding.pry
 follower.save
 redirect_to request.referrer
end

def destroy
 follower = current_user.active_relationships.find_by(followed_id: params[:user_id])     
 follower.destroy
 redirect_to request.referrer
end

end