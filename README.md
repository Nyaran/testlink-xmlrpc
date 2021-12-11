# testlink-xmlrpc

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Test](https://github.com/Nyaran/testlink-xmlrpc/actions/workflows/test.yml/badge.svg)](https://github.com/Nyaran/testlink-xmlrpc/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/Nyaran/testlink-xmlrpc/branch/main/graph/badge.svg?token=JAAQ2DCW9D)](https://codecov.io/gh/Nyaran/testlink-xmlrpc)
[![npm](https://img.shields.io/npm/dw/testlink-xmlrpc)](https://www.npmjs.com/package/testlink-xmlrpc)
[![testlink](https://img.shields.io/badge/TestLink-1.9.20-blue)](https://testlink.org)

[![ko-fi](https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg)](https://ko-fi.com/nyaran)

testlink-xmlrpc is a NodeJS module that connect with TestLink XML-PRC API in order to provide methods to handle Test Suites, Test Case and any other internal functionality exposed in the API.

## Usage

Library is prepared to work with [JS Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise), so you should use them or [Async/Await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)
````typescript
import {TestLink} from 'testlink-xmlrpc';

const testlink = new TestLink({
    host: "testlink.my-server.com",
    port: 8080, // Set if you are not using default port
    secure: true, // Use https, if you are using http, set to false.
    apiKey: "MY_API_KEY", // The API KEY from TestLink. Get it from user profile.
});
````

Now you can interact with TestLink server. E.g.:

### Check connection (with async/await)
````typescript
async function checkConnection() {
    let ping = await testlink.sayHello();
    if (ping === "Hello!") {
        console.log("connection established");
    }
}
````
### Validate API KEY (with Promise)
````typescript
testlink.checkDevKey({devKey: 'APIKEY_to_check'}).then(reply => {
    if (reply === true)
        console.log("API KEY is valid");
    else
        console.log("API KEY is invalid");
});
````
### Create a Test Case (with async/await)
````typescript
async function createTestCase() {
    let testCase = await testlink.createTestCase({
        testprojectid: 5, // Project id in TestLink.
        testsuiteid: 63, // TestSuite id in TestLink.
        testcasename: "This is my new testCase", // Test Case name.
        authorlogin: "my_user", // Author of Test Case.
        summary: "This Test Case is an example", // Test Case description.
        steps: [] // Array containing the Test Case steps.
    });
}
````

## Disclaimer
The development of this project is completely separated from TestLink development. So please, before open any issue here or in TestLink issue tracker, make sure you are opening the ticket in the right place.
