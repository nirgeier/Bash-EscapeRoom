#!/usr/bin/env node

// argv[2] should be the string passed to the function
if (process.argv.length > 2 && process.argv[2] == "showKey") {
    console.log("The key for the next room is");
    console.log("");
    console.log("linuxrocks");
    console.log("");
    console.log("");
} else {
    console.log("The script was not invoked with any parameters.");
    console.log("More information is hidden as `Extended attributes`");
    process.exit();
}

