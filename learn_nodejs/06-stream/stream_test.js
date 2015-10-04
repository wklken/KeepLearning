

// 当内存中无法一次装下需要处理的数据时，或者一边读取一边处理更加高效时，我们就需要用到数据流。NodeJS中通过各种Stream来提供对数据流的操作


// Stream基于事件机制工作，所有Stream的实例都继承于NodeJS提供的EventEmitter。


var fs = require('fs');

function main(argv) {
    var src = argv[0];
    var dest = argv[1];


    var rs = fs.createReadStream(src);
    var ws = fs.createWriteStream(dest);

    rs.on('data', function (chunk) {
        // 根据.write方法的返回值来判断传入的数据是写入目标了，还是临时放在了缓存了，
        if(ws.write(chunk) === false) {
            rs.pause();
        }
    });

    rs.on('end', function () {
        ws.end();
    });


    // 并根据drain事件来判断什么时候只写数据流已经将缓存中的数据写入目标，可以传入下一个待写数据了
    ws.on('drain', function() {
        rs.resume();
    });

}


main(process.argv.slice(2));
