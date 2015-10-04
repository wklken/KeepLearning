

// not working, why?

var child_process = require('child_process');

var child = child_process.spawn('node', ['signal_child.js']);

child.on('close', function(code) {
    console.log('child process exited with code ' + code);
});

child.kill('SIGTERM');
