SuperAgent = require "superagent"
_ = require "underscore"
_s = require "underscore.string"
uuid = require('node-uuid');

module.exports = (robot) ->
  robot.respond /realtime$/i, (msg) ->
    msg.send "#{process.env.M3_HACK3_SIT_BACK_URL}/status"

  robot.respond /history (.+)$/i, (msg) ->
    user_name = msg.match[1]
    url = "#{process.env.M3_HACK3_SIT_BACK_URL}/statuses/histories?user_name=#{user_name}"

    SuperAgent
      .get(url)
      .end (res) -> 
        if res.ok
          histories = JSON.parse(res.text)
          users = _.map(histories, (history) -> 
            new User history
          )
          _.each(users, (user) -> msg.send user.distance)
        else
          msg.send 'sorry...error'

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
    random_value = uuid.v4()

    if @distance == 'out'
      return "#{process.env.M3_HACK3_IMAGE_URL}/#{@name}_out.png?v=#{random_value}"
    else
      return "#{process.env.M3_HACK3_IMAGE_URL}/#{@name}_#{@location}_#{@distance}.png?v=#{random_value}"
