

console.log("hello, I am child");

process.stdout.write("hello");


// 父进程通过.kill方法向子进程发送SIGTERM信号，子进程监听process对象的SIGTERM事件响应信号。不要被.kill方法的名称迷惑了，该方法本质上是用来给进程发送信号的，进程收到信号后具体要做啥，完全取决于信号的种类和进程自身的代码

process.on('SIGTERM', function() {
    cleanUp();
    process.exit(0);
});

// process.exit(0);
