class UsersController < ApplicationController

	def new		
		cookies.delete :username
		cookies.delete :role
		cookies.delete :id
	end

	def create
		@user = User.new(params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation, :role))
		if @user.save
			@msg = "User successfully created"
			cookies[:username] = @user.username
			cookies[:role] = @user.role
			cookies[:id] = @user.id
			redirect_to @user
		else 
			redirect_to root_path(:msg => "User not saved, duplicate username, please try again") 
		end
	end

	def show
		if !!cookies[:username]
			@projects = Project.where(created_by: params[:id])
			@collaborations = Project.joins(:collaborations).where("collaborations.collaborator_id" => params[:id])
			puts "this is #{@collaborations}"
			@user = User.find(params[:id])
		else 
			redirect_to root_path(:msg => "Login info incorrect")
		end
	end

	def update
		@user = User.find_by(id: params[:id])
		if !cookies[:username]
			redirect_to user_path(:msg => "You are no longer logged in, please log in")
		elsif @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
			redirect_to user_path(:msg => "Password updated successfully")
		else
			redirect_to user_path(:msg => "Password was not updated")
		end

	end

	def login
		cookies.delete :username
		cookies.delete :role
		cookies.delete :id
		@user = User.find_by username: params[:user][:username].to_s	
		if (!!@user) && (@user.password == params[:user][:password])
			cookies[:username] = @user.username;
			cookies[:role] = @user.role
			cookies[:id] = @user.id
			redirect_to @user
		else
			redirect_to root_path(:msg => "Login info incorrect")

		end
	end

	def logout
		cookies.delete :username
		cookies.delete :role
		cookies.delete :id
		redirect_to root_path
	end

end
