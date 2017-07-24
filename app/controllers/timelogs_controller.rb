class TimelogsController < ApplicationController
	
	def index
		@timelogs = Timelog.all
	end

	def create
		puts params
		@timelog = Timelog.new(:user_id => params[:user_id], :project_id => params[:project_id], :log_date => Time.now.utc)
		if @timelog.save
			render plain: @timelog.id
		else
			render plain: "fail"
		end
	end

	def update
		@timelog = Timelog.find(params[:id])
		if !!params[:timelog]
			if @timelog.update(note: params[:timelog][:note])
				redirect_to timelogs_path
			else
				redirect_to timelogs_path
			end
		else
			time = 	Time.at(Time.now.utc - @timelog.log_date.utc).utc.strftime("%H:%M:%S")
			if @timelog.update(total_time: time)
				render plain: "Ok"
			else
				render plain: "f"
			end
		end
	end


end
