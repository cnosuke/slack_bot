require 'sinatra'
require 'json'
require './filter'
SLACK_TOKENS = ENV['SLACK_TOKENS'].split(/\,/)

puts "TOKEN: #{SLACK_TOKENS}"

before '/hooks' do
  unless token_valid?
    puts 'Token invalid'
    halt 403, "Token is invalid\n"
  end
  if comment_by_myself?
    puts 'Comment by myself'
    halt 200
  end
end

def token_valid?
  SLACK_TOKENS.include?(params['token'])
end

def comment_by_myself?
 params['user_name'] == 'slackbot'
end

get '/' do
  'Hello world!'
end

post '/hooks' do
  response = filter.update(params).compact.first
  return 200 unless response
  response.merge!({link_names: 1, parse: "full"})
  j = response.to_json
  puts j
  j
end

def filter
  @filter ||= Filter::Pipe.new
end
