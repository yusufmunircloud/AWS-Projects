exports.handler = async function(event, context) {
    console.log("request:", JSON.stringify(event, undefined, 2));
    return {
        statusCode: 200,
        headers: { "Content-Type": "text/plain" },
        body: `Hello from Lambda! You've hit ${event.path}\n`
    };
}
