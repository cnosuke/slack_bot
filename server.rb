require 'sinatra'
require 'json'
require './filter'
SLACK_TOKEN = ENV['SLACK_TOKEN']

puts "TOKEN: #{SLACK_TOKEN}"

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
  params['token'] == SLACK_TOKEN
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
  j = response.to_json
  puts j
  j
end

def filter
  @filter ||= Filter::Pipe.new
end
