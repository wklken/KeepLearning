
/*

 文件属性读写。

 其中常用的有fs.stat、fs.chmod、fs.chown等等。

 文件内容读写。

 其中常用的有fs.readFile、fs.readdir、fs.writeFile、fs.mkdir等等。

 底层文件操作。

 其中常用的有fs.open、fs.read、fs.write、fs.close等等
*/


var fs = require('fs');

function async_read(path) {
    fs.readFile(path, function(err, data) {
        if(err) {
            console.log("Read File Fail");
        } else {
            console.log('async:' + data);
        }
    });
}


function sync_read(path) {
    try {
        var data = fs.readFileSync(path);
        console.log('sync:' + data);
    } catch (e) {
        /* handle error */
        console.log(e);
    }
}

function main(argv) {
    var path = argv[0];
    async_read(path);
    sync_read(path);
}

main(process.argv.slice(2));
