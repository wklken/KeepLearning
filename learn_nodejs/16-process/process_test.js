


// NodeJS程序的标准输入流（stdin）、一个标准输出流（stdout）、一个标准错误流（stderr）分别对应process.stdin、process.stdout和process.stderr

function main(argv) {
    try {
        var a = argv[0] / b;
    } catch(err) {
        console.log("Error: " + err);
        process.stdout.write("print into stdout");
        process.exit(1);
    }
}


main(process.argv.slice(2));
