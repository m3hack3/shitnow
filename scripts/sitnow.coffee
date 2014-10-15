SuperAgent = require "superagent"

module.exports = (robot) ->
  robot.respond /hoge$/i, (msg) ->
    msg.send "fuge"

  robot.respond /where$/i, (msg) ->
    url = process.env.M3_HACK3_SIT_BACK_URL

    SuperAgent
      .get(url)
      .end (res) -> 
        if res.ok
          msg.send res.text
        else
          msg.send 'sorry...error'
