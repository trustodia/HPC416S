# PHP code samples for Futuregateway warm-up

This repository contains some trivial examples that can be used during the Futuregateway warm-up

## How to use the code
1. Create a new Futuregateway task:
`php createTask.php `
The expected output should be something like:
``` javascript
 {
   "status": "WAITING",
   "application": "2",
   "date": "2016-11-16T12:27:47Z",
   "description": "sayhello@csgfsdk test run",
   "output_files": [
        {
            "url": "file?path=&name=sayhello.data",
            "name": "sayhello.data"
        },
        {
            "url": "file?path=&name=sayhello.out",
            "name": "sayhello.out"
        },
        {
            "url": "file?path=&name=sayhello.err",
            "name": "sayhello.err"
        }
      ],
      "_links": [
        {
            "href": "/v1.0/tasks/19",
            "rel": "self"
        },
        {
            "href": "/v1.0/tasks/19/input",
            "rel": "input"
        }
      ],
      "user": "gridct",
      "input_files": [
        {
            "status": "NEEDED",
            "name": "sayhello.sh"
        },
        {
            "status": "NEEDED",
            "name": "sayhello.txt"
        }
      ],
      "id": "19",
      "arguments": [
        "\"I am saying hello!\""
      ]
    }
```
1. Then you should upload you input file:
`php uploadInput.php <task_id> sayhello.sh`
```javascript
{
  "files": [
        "sayhello.sh"
  ],
  "message": "uploaded",
  "task": "19",
  "gestatus": "waiting"
}
```
`php uploadInput.php <task_id> sayhello.txt`
```javascript
{
  "files": [
      "sayhello.txt"
  ],
  "message": "uploaded",
  "task": "19",
  "gestatus": "triggered"
}
```
Replace `<task_id>` with the task id value returned from the previous call, as soon as each input file has been uploaded the task will start its execution, look at the output of the second upload command.

3. Check task status with.
`php checkTask.php <task_id>`
```javascript
{
  "status": "DONE",
  "description": "sayhello@csgfsdk test run",
  "creation": "2016-11-16T12:27:47Z",
  "iosandbox": "/tmp/14dafa48-abf8-11e6-b19b-fa163e72d9ab",
  "user": "gridct",
  "id": "19",
  "output_files": [
      {
          "url": "file?path=%2Ftmp%2F14dafa48-abf8-11e6-b19b-fa163e72d9ab%2F19tmp14dafa48abf811e6b19bfa163e72d9ab_49&name=sayhello.data",
          "name": "sayhello.data"
      },
      {
          "url": "file?path=%2Ftmp%2F14dafa48-abf8-11e6-b19b-fa163e72d9ab%2F19tmp14dafa48abf811e6b19bfa163e72d9ab_49&name=sayhello.out",
          "name": "sayhello.out"
      },
      {
          "url": "file?path=%2Ftmp%2F14dafa48-abf8-11e6-b19b-fa163e72d9ab%2F19tmp14dafa48abf811e6b19bfa163e72d9ab_49&name=sayhello.err",
          "name": "sayhello.err"
      }
  ],
  "application": "2",
  "arguments": [
      "\"I am saying hello!\""
  ],
  "runtime_data": [],
  "input_files": [
      {
          "status": "READY",
          "url": "file?path=%2Ftmp%2F14dafa48-abf8-11e6-b19b-fa163e72d9ab&name=sayhello.sh",
          "name": "sayhello.sh"
      },
      {
          "status": "READY",
          "url": "file?path=%2Ftmp%2F14dafa48-abf8-11e6-b19b-fa163e72d9ab&name=sayhello.txt",
          "name": "sayhello.txt"
      }
  ],
  "last_change": "2016-11-16T12:30:23Z"
}
```
4. As soon as the task status is **DONE** you can download the output using:
`php retrieveOutput.php <task_id> "<...&name=sayhello.data>" <...&name=sayhello.out> &name=sayhello.err` 
