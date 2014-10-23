SuperAgent = require "superagent"
_ = require "underscore"
_s = require "underscore.string"
uuid = require('node-uuid');

module.exports = (robot) ->
  robot.hear /realtime (.+)$/i, (msg) ->
    msg.send "#{process.env.M3_HACK3_SIT_BACK_URL}/status"

  robot.hear /history (.+)$/i, (msg) ->
    user_name = msg.match[1]
    url = "#{process.env.M3_HACK3_SIT_BACK_URL}/statuses/histories?user_name=#{user_name}"

    SuperAgent
      .get(url)
      .end (res) -> 
        if res.ok
          history = new History JSON.parse(res.text)
          msg.send history.message()
        else
          msg.send 'sorry...error'

  robot.hear /where (.+)$/i, (msg) ->
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

class History
  constructor: (user_datas) -> 
    @users = _.map(user_datas, (user_data) -> (new User user_data))

  message: ->
    return _.reduce(@users, ((memo, user) -> (memo += "#{user.description()}\n")), '')

class User
  constructor: (options) -> 
    if options.user_name?
      @name = options.user_name.toLowerCase() 
    if options.location?
      @location = options.location.toLowerCase()
    if options.distance?
      @distance = options.distance.toLowerCase()

  image: ->
    random_value = uuid.v4()

    if @distance == 'out'
      return "#{process.env.M3_HACK3_IMAGE_URL}/#{@name}_out.png?v=#{random_value}"
    else
      return "#{process.env.M3_HACK3_IMAGE_URL}/#{@name}_#{@location}_#{@distance}.png?v=#{random_value}"

  description: ->
    if @distance == 'out'
      return "#{@name}さんは、行方不明"
    else
      return "#{@name}さんは、「#{@location_human_readable()}」の#{@distance_human_readable()}にいました"

  location_human_readable: ->
    res = switch @location
      when "desk" then "席"
      when "toilet" then ":shit:"
      else "不明"

    return res

  distance_human_readable: ->
    res = switch @distance
      when "immediate" then "すぐ近く"
      when "near" then "近く"
      when "far" then "遠く"
      else "不明"

    return res
