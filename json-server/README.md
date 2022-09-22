# JSON Server

Get a full fake REST API with __zero coding__ in __less than 30 seconds__ (seriously)

Created with <3 for front-end developers who need a quick back-end for prototyping and mocking.

https://github.com/typicode/json-server

* [Egghead.io free video tutorial - Creating demo APIs with json-server](https://egghead.io/lessons/nodejs-creating-demo-apis-with-json-server)
* [JSONPlaceholder - Live running version](https://jsonplaceholder.typicode.com)
* [__My JSON Server__ - no installation required, use your own data](https://my-json-server.typicode.com)

See also:
* :dog: [husky - Git hooks made easy](https://github.com/typicode/husky)
* :owl: [lowdb - local JSON database](https://github.com/typicode/lowdb)
* ✅ [xv - a beautifully simple and capable test runner](https://github.com/typicode/xv)

```
Options:
  --config, -c               Path to config file   [default: "json-server.json"]
  --port, -p                 Set port                            [default: 3000]
  --host, -H                 Set host                       [default: "0.0.0.0"]
  --watch, -w                Watch file(s)                             [boolean]
  --routes, -r               Path to routes file
  --middlewares, -m          Paths to middleware files                   [array]
  --static, -s               Set static files directory
  --read-only, --ro          Allow only GET requests                   [boolean]
  --no-cors, --nc            Disable Cross-Origin Resource Sharing     [boolean]
  --no-gzip, --ng            Disable GZIP Content-Encoding             [boolean]
  --snapshots, -S            Set snapshots directory              [default: "."]
  --delay, -d                Add delay to responses (ms)
  --id, -i                   Set database id property (e.g. _id) [default: "id"]
  --foreignKeySuffix, --fks  Set foreign key suffix (e.g. _id as in post_id)
                                                                 [default: "Id"]
  --quiet, -q                Suppress log messages from output         [boolean]
  --help, -h                 Show help                                 [boolean]
  --version, -v              Show version number                       [boolean]

Examples:
  json-server db.json
  json-server file.js
  json-server http://example.com/db.json
```
