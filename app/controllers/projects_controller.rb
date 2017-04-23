class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def create
		@user = User.find(cookies[:id])
		params[:project][:created_by] = cookies[:id]
		params[:project][:status] = "incomplete"
		@project = Project.new(params.require(:project).permit(:created_by,:title, :description,:status))
		if @project.save
			redirect_to @user
		else 
			redirect_to @user
		end
	end

	def show
		if !!cookies[:username]
			@project = Project.find(params[:id])
		else
			redirect_to root_path(:msg => "You are not logged in, please log in")
		end
	end


	def destroy
		if ((!!cookies[:username]) && (cookies[:role] == "admin"))
			@project = Project.find(params[:id])
			@project.destroy

			redirect_to projects_path
		end
	end
end
