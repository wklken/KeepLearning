

var fs = require('fs');
var path = require('path');

function travel(dir, callback) {
    fs.readdirSync(dir).forEach(function (file) {
        var pathname = path.join(dir, file);

        if(fs.statSync(pathname).isDirectory()) {
            travel(pathname, callback);
        } else {
            callback(pathname);
        }
    });
}


function print_path(pathname) {
    console.log(pathname);
}

function main(argv) {
    var dir = argv[0];
    travel(dir, print_path);
}

main(process.argv.slice(2));
