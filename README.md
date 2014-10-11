今、席にいます - m3ハッカソン チーム3 

## 案1. macをibeacon受信側にする（iphoneは発信側）

```
iphoneのアプリ（estimote)がibeacon発信
=> mac(node.js,hubot）が受信
=> skypeとかに通知
```

[プロトタイプ](./myhubot)作りました




## 案2. macをibeacon発信側にする（iphoneは受信側）

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

発信完了！

手っ取り早く信号を確認するなら、以下のアプリをiphoneにインストールして、上記uuidを設定すればok

https://itunes.apple.com/jp/app/bluetus-for-ibeacon-ranging/id734155067?mt=8

