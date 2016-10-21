require 'slack-ruby-client'

@counter ||= 0

Slack.configure do |config|
  p ENV.inspect
  p ENV['SLACK_API_TOKEN'].inspect
  config.token = ENV['SLACK_API_TOKEN']
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  user = client.users[data.user]['name']

  if user == "satcha"
    @counter += 1
    if @counter % 2 == 0
      client.message channel: data.channel, text: "<@#{data.user}>, por que no sos una nina normal??!!"
    else
      client.message channel: data.channel, text: "Su cara es un #{data.text}!!!!!!!!!"
    end
  end

  if data.text.match(/dele/)
    client.message channel: data.channel, text: "<@#{data.user}>, dele vuelticas!"
  end

  if data.text.match(/pregunta/)
    client.message channel: data.channel, text: "Que se siente ser zacate?"
  end
end

client.on :close do |_data|
  puts 'Connection closing, exiting.'
end

client.on :closed do |_data|
  puts 'Connection has been disconnected.'
end

client.start!
