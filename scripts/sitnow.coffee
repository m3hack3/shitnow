SuperAgent = require "superagent"
_ = require "underscore"
_s = require "underscore.string"

module.exports = (robot) ->
  robot.respond /hoge$/i, (msg) ->
    msg.send "Fuge".toLowerCase()

  robot.respond /where (.+)$/i, (msg) ->
    user_name = msg.match[1]
    url = "#{process.env.M3_HACK3_SIT_BACK_URL}/statuses?user_name=#{user_name}"

    SuperAgent
      .get(url)
      .end (res) -> 
        if res.ok
          user = new User JSON.parse(res.text)
          msg.send user.image()
        else
          msg.send 'sorry...error'

class User
  constructor: (options) -> 
    @name = options.user_name.toLowerCase()
    @location = options.location.toLowerCase()
    @distance = options.distance.toLowerCase()

  image: ->
    return "#{process.env.M3_HACK3_IMAGE_URL}/#{@name}_#{@location}_#{@distance}.png"
