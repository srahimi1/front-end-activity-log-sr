json.timelogs @timelogs do |timelog|
	json.id timelog.id
	json.log_date timelog.log_date.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y %-I:%M %p")
	json.user timelog.user.username
	json.project timelog.project.title
	json.amount_time timelog.total_time
	json.note timelog.note
end