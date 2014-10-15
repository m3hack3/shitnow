module.exports = (robot) ->
  robot.respond /hoge$/i, (msg) ->
    msg.send "fuge"
