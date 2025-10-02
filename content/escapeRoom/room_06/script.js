#!/usr/bin/env node

const
    fs = require('fs'),
    path = require('path'),
    fileName = path.join(__dirname, 'message');

// Check if we have the required file in the folder
fs.access(fileName,
    fs.constants.F_OK,
    (err) => {
        if (err) {
            console.log("---------------------------------------")
            console.log("| Can't find the message in the folder |");
            console.log("---------------------------------------|")
            process.exit();
        }
    });

// Check to see if we have the message file in folder
fs.readFile(fileName,
    'utf8',
    (err, data) => {
        if (err) {
            console.log('Error: ');
            console.log(err);
            process.exit();
        }
        // read the file content (line by line)
        const lines = data.split('\n');

        // Combine the message to a single string
        const content = lines.join('').trim();
        if (content === "keepupthegoodwork") {
            console.log("")
            console.log("Linux Bash released in 1989,");
            console.log("it has been used as the default login shell for most Linux distributions");
            console.log("and it was one of the first programs Linus Torvalds ported to Linux.");
            console.log("")
            console.log("")
            console.log("The key for the next room is (case sensitive)");
            console.log("");
            console.log("     LinusTorvalds");
            console.log("");
            process.exit();
        }

        console.log("The message in the file is wrong.");
        console.log("Try again");

    });


