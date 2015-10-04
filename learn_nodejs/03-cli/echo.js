#!/usr/bin/env node


# chmod u+x echo.js
# ./echo.js abc def


function main(argv) {
    console.log(argv.join(' '));
}

main(process.argv.slice(2));
