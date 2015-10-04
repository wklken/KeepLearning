
var http = require('http');

var options = {
    hostname: '127.0.0.1',
    port: 8000,
    path: '/upload',
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
    }
};


// method - 1
// var request = http.request(options, function(response) { console.log(response.headers); });
// request.write('hello world');
// request.end();


http.get('http://127.0.0.1:8000', function(response) {
    var body = [];

    console.log(response.statusCode);
    console.log(response.headers);

    response.on('data', function(chunk) {
        body.push(chunk);
    });

    response.on('end', function() {
        body = Buffer.concat(body);
        console.log(body.toString());
    });
});
