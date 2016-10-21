require 'slack-ruby-bot'

class PapitasBot < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end
end

PapitasBot.run
