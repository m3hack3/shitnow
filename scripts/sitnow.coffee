SuperAgent = require "superagent"
_ = require "underscore"

module.exports = (robot) ->
  robot.respond /hoge$/i, (msg) ->
    msg.send "fuge"

  robot.respond /where (.+)$/i, (msg) ->
    user_name = msg.match[1]

    url = process.env.M3_HACK3_SIT_BACK_URL

    SuperAgent
      .get(url)
      .end (res) -> 
        if res.ok
          user = JSON.parse(res.text)
          msg.send "#{user.user_name}は#{user.location_name}の#{user.distance}にいます"
        else
          msg.send 'sorry...error'
