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
#   None
#
# Commands:
#   hubot conference - create an audio conference room.
#
# Author:
#   DHfromKorea <dh@dhfromkorea.com>

module.exports = (robot) ->
  robot.respond /conference/i, (msg) ->
    msg.http('http://www.voicechatapi.com/api/v1/conference/')
       .post() (err, res, body) ->
         json = JSON.parse(body)
         msg.send "Your conference room: #{json.conference_url} \n*This room will be automatically removed after 24 hours. More info on www.voicechatapi.com"
