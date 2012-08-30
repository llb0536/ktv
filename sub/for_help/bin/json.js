#!/usr/bin/env node

    var tree = function(x) { console.log(JSON.stringify(x, null, 2)) };
    process.stdin.resume();
    process.stdin.setEncoding('utf8');
     
     process.stdin.on('data', function (chunk) {
       tree(JSON.parse(chunk));
     });
