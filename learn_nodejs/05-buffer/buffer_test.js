
// JS语言自身只有字符串数据类型，没有二进制数据类型，因此NodeJS提供了一个与String对等的全局构造函数Buffer来提供对二进制数据的操作

var bin = new Buffer([ 0x68, 0x65, 0x6c, 0x6c, 0x6f ]);

console.log(bin);
console.log(bin.length);
console.log(bin[0]);


// to string
var str = bin.toString('utf-8'); // => "hello"
console.log(str);


// to buffer
var bin2 = new Buffer('hello', 'utf-8'); // => <Buffer 68 65 6c 6c 6f>
console.log(bin2);


// Buffer与字符串有一个重要区别。字符串是只读的，并且对字符串的任何修改得到的都是一个新字符串，原字符串保持不变。
// 至于Buffer，更像是可以做指针操作的C语言数组。例如，可以用[index]方式直接修改某个位置的字节

bin2[0] = 0x48;
console.log(bin2);
console.log(bin2.toString("utf-8"));


// 而.slice方法也不是返回一个新的Buffer，而更像是返回了指向原Buffer中间的某个位置的指

sub = bin2.slice(2);
console.log(sub);
console.log(sub.toString('utf-8'));


// 如果想要拷贝一份新的buffer

var bin = new Buffer([ 0x68, 0x65, 0x6c, 0x6c, 0x6f ]);
var dup = new Buffer(bin.length);
bin.copy(dup);
dup[0] = 0x48;
console.log(bin); // => <Buffer 68 65 6c 6c 6f>
console.log(dup); // => <Buffer 48 65 65 6c 6f>
