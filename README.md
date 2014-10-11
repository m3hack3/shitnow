shitnow
=======

## macでibeacon発行

node.jsとnpmインストール済みであること

```
$ npm install bleacon
```

```
$ uuidgen
```

beacon.js

```JavaScript
Bleacon = require('bleacon');

var uuid = 'xxx'; //uuidgenで生成したID
var major = 0;
var minor = 0;
var measuredPower = -59;

Bleacon.startAdvertising(uuid, major, minor, measuredPower);
```

```
$ node beacon.js
```
