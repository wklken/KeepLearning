var http = require('http');
var url = require('url');


function start(route, handle) {
    function onRequest(request, response) {
        // console.log("Request received");
        var pathname = url.parse(request.url).pathname;
        console.log("Request for " + pathname + " received");

        // v3
        route(handle, pathname, response, request);

        // v2
        // var postData = '';
        // request.setEncoding("utf-8");
        // request.addListener("data", function(postDataChunk) {
            // postData += postDataChunk;
            // console.log("Received POST Data chunk [" + "]");
        // });
        // request.addListener("end", function() {
            // route(handle, pathname, response, postData);
        // });

        // v1
        // route(handle, pathname, response);

        // response.writeHead(200, {"Content-Type": "text/plain"});
        // response.write("Hello World");
        // response.end();
    }
    http.createServer(onRequest).listen(8000);
    console.log("Server has started");
}

exports.start = start;

