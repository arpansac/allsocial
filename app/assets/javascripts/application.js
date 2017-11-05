// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


window.addEventListener('load', function(){
	var user_email = $('#logged-in-user-email').val();
	var socket = io.connect('http://13.126.192.223:8005');

	socket.on('connect', function(){
		console.log('handshake completed');
		socket.emit('join_room', {user_email: user_email});
	});

	socket.on('user_joined', function(data){
		console.log(data.user_email + ' also joined you');
	});

	$('#send-message').click(function(){
		var newMessage = $('#chat-message-input').val();

		if (newMessage != ''){
			socket.emit('send_message', {user_email: user_email, message: newMessage});
		}
	});

	socket.on('receive_message', function(data){
		console.log(data.user_email + ' sent message ' + data.message);
		appendMessage(data.message, data.user_email);
	});


	function appendMessage(message, email){
		var rMessage = $('<li>');
		rMessage.append($('<span>', {
			html: message
		}));
		if (email == user_email){
			// self message
			rMessage.addClass('self-message');

		}else if(email == undefined){
			rMessage.addClass('other-message');
		}else{
			// other message
			rMessage.addClass('other-message');
		}

		$('#chat-messages-list').append(rMessage);
	}


});

















