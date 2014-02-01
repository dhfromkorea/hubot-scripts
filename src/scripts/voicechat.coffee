# Description:
#   Voice Chat API is an open-source audio conferencing app exposed via an API.
#   This plugin makes a POST request to fetch the UR of a conference room where you can do a simple
#   WebRTC-powered voice calls in browsers. The room will last for the next 24
#   hours. VoiceChatAPI Learn more on http://VoiceChatAPI.com
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_VOICECHAT_HOST - (optional) The base URL of a self-hosted instance of the Voice Chat API.
#   HUBOT_VOICECHAT_EXPIRE_CONFERENCE - (optional) True if conference is set to expire after 24 hours of inactivity
#
# Commands:
#   hubot conference - create an audio conference room.
#
# Author:
#   DHfromKorea <dh@dhfromkorea.com>
module.exports = (robot) ->
  url = "http://www.voicechatapi.com"
  purgeMessage = ""

  if process.env.HUBOT_VOICECHAT_HOST?
    url = process.env.HUBOT_VOICECHAT_HOST
  
  if not process.env.HUBOT_VOICECHAT_EXPIRE_CONFERENCE? or process.env.HUBOT_VOICECHAT_EXPIRE_CONFERENCE is true
    purgeMessage = " \n*This room will be automatically removed after 24 hours. More info at #{url}"

  robot.respond /conference|voicechat/i, (msg) ->
    msg.http("#{url}/api/v1/conference/")
      .post() (err, res, body) ->
        if not err and res.statusCode is 200
          json = JSON.parse(body)
          msg.send "Your conference room: #{json.conference_url}#{purgeMessage}"
        else
          robot.logger.error "Unable to create conference at #{url}", err, res
          msg.send "Sorry, but I was unable to create a conference for you."
