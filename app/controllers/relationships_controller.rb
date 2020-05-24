class RelationshipsController < ApplicationController
	before_action :set_user

	def create
		following = current_user.follow(@user)
		if following.save
			flash[:success] = 'ユーザーをフォローしました'
			redirect_back(fallback_location: root_path) 
		else
			flash.now[:alert] = 'ユーザーのフォローに失敗しました'
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = 'ユーザーのフォローを解除しました'
			redirect_back(fallback_location: root_path)
		else
			flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
			redirect_back(fallback_location: root_path)
		end
	end

	def following
		@user = User.find(params[:id])
		@users = @user.followings
		redirect_back(fallback_location: root_path)
	end

	def followers
		@user = User.find(params[:id])
		@users = @user.followers
		redirect_back(fallback_location: root_path)
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
end