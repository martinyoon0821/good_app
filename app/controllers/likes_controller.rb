class LikesController < ApplicationController
    def create
        like = Like.find_by(board_id: params[:board_id], user_id: current_user.id)
        
        if like.present?
            like.destroy
        else
            Like.create(board_id: params[:board_id], user_id: current_user.id)
        end
        
        redirect_back(fallback_location: root_path)
        
    end
end
