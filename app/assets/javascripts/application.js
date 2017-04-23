// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function checkPassword() {
	var error = document.getElementById("enroll_error_message");
	error.style.display = "block";
	if (  (document.getElementById("new_user_first_name").value.replace(/\s/g, "").length == 0) ||  ( document.getElementById("new_user_last_name").value.replace(/\s/g, "").length == 0 ) )
		error.innerHTML = "Both first and last name must be given";
	else if ( document.getElementById("new_username").value.replace(/\s/g, "").length < 4 )
		error.innerHTML = "Username must be at least 4 characters long";
	else if ( document.getElementById("new_user_password").value.replace(/\s/g, "").length < 4 )
		error.innerHTML = "Password must be at least 4 characters long"
	else if (document.getElementById("new_user_password").value != document.getElementById("password_confirm").value)
		error.innerHTML = "Passwords do not match, they must match"; 
	else {
		error.innerHTML = "";
		error.style.display = "none";
		document.getElementById("enroll_form").submit();
	}
}


function checkPasswordMatch() {
	var error = document.getElementById("change_password_error_message");
	error.style.display = "block";
	if ( document.getElementById("user_new_password").value.replace(/\s/g, "").length < 4 )
		error.innerHTML = "Password must be at least 4 characters long"
	else if (document.getElementById("user_new_password").value != document.getElementById("password_confirm").value)
		error.innerHTML = "Passwords do not match, they must match"; 
	else {
		error.innerHTML = "";
		error.style.display = "none";
		document.getElementById("change_password_form").submit();
	}
}

function closeThis(el) {
	el.parentNode.style.display="none";
}


function addDescription(el) {
	var content = document.getElementById("showDescriptionP");
	content.innerHTML = el.parentNode.nextSibling.nextSibling.innerHTML;
}

function getTimelogContentJSON() {
	var request = new XMLHttpRequest();
	request.onreadystatechange = populatePage;
	request.open("GET","/timelogs.json", true);
	request.send();
}

function populatePage() {
	if(this.readyState == 4 && this.status == 200)
	{	
		var timelogs = JSON.parse(this.responseText).timelogs;
		document.getElementById("logs-table").style.display = "table";
		var content = document.getElementById("logs-table-body");
		var el = "";
		for (i = 0 ; i < timelogs.length ; i++) {
			el += "<tr><td>"+timelogs[i].log_date+"</td><td>"+timelogs[i].user+"</td><td>"+timelogs[i].project+"</td><td>"+timelogs[i].amount_time+"</td><td><a href='#' data-toggle='modal' data-target='#showNote' onclick='fillNoteForm("+JSON.stringify(timelogs[i].note)+","+JSON.stringify(timelogs[i].id)+")'>"+timelogs[i].note+"</a></td></tr>";
			} // end for loop
		content.innerHTML = el;
	}

}

function fillNoteForm(note,id) { 
	console.log(note);
	document.getElementById("edit_note_form").setAttribute("action","/timelogs/"+id);
	document.getElementById("note-field").value = note;
}

function startActivity(user,project_id) {
	document.getElementById("activity-status").innerHTML = "Wait for activity status update"
	var activityResponse = new XMLHttpRequest();
	activityResponse.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			console.log(this.responseText);
			if (this.responseText != "fail") {
				document.getElementById("stop-activity-btn").setAttribute("onclick","stopActivity("+this.responseText+")");
				document.getElementById("activity-status").innerHTML = "<div class='alert alert-success' role='alert'><strong>Activity Started!</strong></div>";
			}
		} // if (this.readyState)
	} // if activityResponse
	activityResponse.open("POST","/api/timelogs", true);
	activityResponse.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	activityResponse.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	activityResponse.send("user_id="+user+"&project_id="+project_id);
}

function stopActivity(activity_id) {
	document.getElementById("activity-status").innerHTML = "Wait for activity status update"
	var activityResponse = new XMLHttpRequest();
	activityResponse.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText == "Ok") {
				document.getElementById("activity-status").innerHTML = "<div class='alert alert-warning' role='alert'><strong>Activity Stopped!</strong></div>";
			}
		} // if (this.readyState)
	} // if activityResponse
	activityResponse.open("PATCH","/api/timelogs/"+activity_id, true);
	activityResponse.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	activityResponse.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	activityResponse.send();
}