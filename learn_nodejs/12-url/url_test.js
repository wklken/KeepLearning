

/*
 *                            href
 -----------------------------------------------------------------
                            host              path
                      --------------- ----------------------------
 http: // user:pass @ host.com : 8080 /p/a/t/h ?query=string #hash
 -----    ---------   --------   ---- -------- ------------- -----
protocol     auth     hostname   port pathname     search     hash
                                                ------------
                                                   query
*/

// 处理HTTP请求时url模块使用率超高，因为该模块允许解析URL、生成URL，以及拼接URL。


// parse
// .parse方法还支持第二个和第三个布尔类型可选参数。第二个参数等于true时，该方法返回的URL对象中，query字段不再是一个字符串，而是一个经过querystring模块转换后的参数对象。第三个参数等于true时，该方法可以正确解析不带协议头的URL，例如//www.example.com/foo/bar。

var url = require('url');

var result = url.parse('http://user:pass@host.com:8080/p/a/t/h?query=string#hash');
console.log(result);
// Url {
  // protocol: 'http:',
  // slashes: true,
  // auth: 'user:pass',
  // host: 'host.com:8080',
  // port: '8080',
  // hostname: 'host.com',
  // hash: '#hash',
  // search: '?query=string',
  // query: 'query=string',
  // pathname: '/p/a/t/h',
  // path: '/p/a/t/h?query=string',
  // href: 'http://user:pass@host.com:8080/p/a/t/h?query=string#hash' }


console.log(url.parse('/foo/bar?a=b'));


// format

var a_url = url.format({
    protocol: 'http:',
    host: 'www.example.com',
    pathname: '/p/a/t/h',
    search: 'query=string'
});

console.log(a_url);

// resolve

var b_url = url.resolve('http://www.example.com/foo/bar', '../baz');
console.log(b_url);
