

// 而http模块创建的HTTP服务器在接收到完整的请求头后，就会调用回调函数。
// 在回调函数中，除了可以使用request对象访问请求头数据外，还能把request对象当作一个只读数据流来访问请求体数据
var http = require('http');

http.createServer(function(request, response) {
    var body = [];

    console.log(request.method);
    console.log(request.headers);

    request.on('data', function(chunk) {
        body.push(chunk);
    });

    request.on('end', function() {
        body = Buffer.concat(body);
        console.log(body.toString());
    });
}).listen(8000);
