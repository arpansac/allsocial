console.log('Booting Chat Server...');

var http = require('http');
console.log('acquired http, now creating server...');
var server = http.createServer().listen(5000, '192.168.1.48');

console.log('chat server started!');


var mySockets = require('socket.io').listen(server);


mySockets.on('connection', function(socket){
	console.log('new user connected');

	socket.on('disconnect', function(){
		console.log('Got disconnect!');
	})

	socket.on('join_room', function(data){
		socket.join('alchemy2017');
		console.log(data.user_email + ' joined alchemy2017');

		mySockets.in('alchemy2017').emit('user_joined', {'user_email': data.user_email});
	});


	socket.on('send_message', function(data){
		console.log(data.user_email + ' sent message ' + data.message);

		mySockets.in('alchemy2017').emit('receive_message', data);
	});



});










