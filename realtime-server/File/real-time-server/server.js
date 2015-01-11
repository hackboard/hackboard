var io = require('socket.io').listen(33555),
    redis = require('redis').createClient();

redis.auth('12345678' , function(){});

redis.subscribe('hb');
console.log("Socket.io Start");
io.on('connection' , function(socket){
    console.log("connection from:" + socket.handshake.address);
    redis.on('message' , function(channel , message){
	try{
	    socket.emit('hb' , JSON.parse(message));
	}catch(e){}
    });
});

