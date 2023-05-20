extends Control

var webApiKey = "AIzaSyApRPf0C2CGtUJhDhuIk1YmdwxSFhwgf6o"
var signupURL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
var loginURL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
var postdb = "https://freefallfighters.firebaseio.com/message_list.json"
#login and signup function

func _loginSignup(url: String, email: String, password : String):
	var http = $HTTPRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email': email,'password':password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url,headers,HTTPClient.METHOD_POST,body)


func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	#si la respuesta es correcta
	if (response_code == 200):
		
		print(response)
		get_tree().change_scene_to_file("res://Maps/main_menu.tscn")
	else:
		if response.error.message == "INVALID_EMAIL":
			$ColorRect/VBoxContainer/MarginContainer4/error_label.text = "Insert a correct email"
		elif response.error.message =="EMAIL_NOT_FOUND":
			$ColorRect/VBoxContainer/MarginContainer4/error_label.text = "Email not found"
		else:
			$ColorRect/VBoxContainer/MarginContainer4/error_label.text = response.error.message
			


func _on_signup_pressed():
	var url =signupURL + webApiKey
	var email = $ColorRect/VBoxContainer/MarginContainer/email.text
	var password = $ColorRect/VBoxContainer/MarginContainer2/password.text
	_loginSignup(url, email, password)
	


func _on_login_pressed():
	var url = loginURL + webApiKey
	var email = $ColorRect/VBoxContainer/MarginContainer/email.text
	var password = $ColorRect/VBoxContainer/MarginContainer2/password.text
	_loginSignup(url, email, password)
	
