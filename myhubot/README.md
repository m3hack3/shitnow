# ibeacon発信端末が近づくと、つぶやくhubot

## Dependencies

### node.jsとnpm

### redis

hubotがデータ保存に使うそうなのでインストール

```
$ brew install redis
```

### ibeacon発信端末

iphoneにestimoteをインストールして、virtual beacon起動させるのが楽です
https://itunes.apple.com/us/app/estimote/id686915066?mt=8

## how to use

redis起動

```
$ redis-server /usr/local/etc/redis.conf
```

hubot起動

```
$ bin/hubot
```

ibeacon発信端末を近づけると

```
Hubot> ちゅーかねー、今席にいます
```

遠ざけると

```
Hubot> ちゅーかねー、ちょと席離れた
```
