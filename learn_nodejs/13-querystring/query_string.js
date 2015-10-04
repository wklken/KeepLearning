


var querystring = require('querystring');

var result = querystring.parse('foo=bar&baz=qux&baz=quux&corge');
console.log(result);


var toquery = querystring.stringify({ foo: 'bar', baz: ['qux', 'quux'], corge: '' });
console.log(toquery);

