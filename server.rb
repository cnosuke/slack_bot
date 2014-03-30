require 'sinatra'
require './filter'
SLACK_TOKEN = ENV['SLACK_TOKEN']

puts "TOKEN: #{SLACK_TOKEN}"

before '/hooks' do
  halt 403, "Token is invalid\n" unless token_valid?
end

def token_valid?
  params['token'] == SLACK_TOKEN
end

get '/' do
  'Hello world!'
end

post '/hooks' do
  response = filter.update(params)
  return 200 unless response
  response
end

def filter
  @filter ||= Filter::Pipe.new
end
