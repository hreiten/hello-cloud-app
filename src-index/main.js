const fs = require("fs");

const sha = process.env.GIT_SHA ? process.env.GIT_SHA : 1;
const environment = process.env.NODE_ENV === "prod" ? "prod" : "dev";
const url = "https://hello-cloud-assets.s3.eu-north-1.amazonaws.com";
const date = new Date().toISOString();

const index = `<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="apple-touch-icon" href="${url}/public/apple-touch-icon.png" />
    <link rel="manifest" href="${url}/public/manifest.json" />
    <link rel="shortcut icon" href="${url}/public/favicon.ico" />
    <meta name="description" content="Hello World implementation of SPA in AWS">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Hello Cloud [${environment}]</title>
  </head>
  <body>
       <!-- environment variables -->
       <script>
       env = {
           ENV_NAME: '${environment}',
           GIT_SHA: '${sha}',
           API_URL: '${url}',
           CREATED_AT: '${date}'
       }
       </script>
       <!-- application binding -->
       <app-root></app-root>
       <!-- fully-qualified static assets -->
       <script src="${url}/assets/${sha}/main.js" type="text/javascript"></script>
   </body>
</html>`;

fs.writeFile("index.html", index, "utf8", function() {});
