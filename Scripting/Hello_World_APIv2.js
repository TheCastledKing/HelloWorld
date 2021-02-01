'use strict';
console.log('Loading hello world function');


exports.handler = async (event) => {
    let name = "World";
    let responseCode = 200;
    console.log("request: " + JSON.stringify(event));
    
    if (event.queryStringParameters && event.queryStringParameters.name) {
        console.log("Received name: " + event.queryStringParameters.name);
        name = event.queryStringParameters.name;
    }
    
    let greeting = `Hello, ${name}!`;

    let responseBody = {
        greeting
    };
    
    let response = {
        statusCode: responseCode,
headers: {
        "x-custom-header" : "my custom header value",
        "Access-Control-Allow-Origin":"*"
        },
        body: JSON.stringify(responseBody)
    };
    console.log("response: " + JSON.stringify(response))
    return response;
};
