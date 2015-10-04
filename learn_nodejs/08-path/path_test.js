
var path = require('path');


var p1 = path.normalize('foo/baz');
var p2 = path.normalize('foo//baz//../bar');

console.log(p1);
console.log(p2);

var p3 =  path.join('foo/', 'baz/', '../bar'); // => "foo/bar"
console.log(p3);

var ext =   path.extname('foo/bar.js'); // => ".js"
console.log(ext);

