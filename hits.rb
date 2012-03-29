require 'json'
require 'redis'
require 'sinatra'

class Hits < Sinatra::Application
  begin
    c = JSON.parse(ENV['VCAP_SERVICES'])
    host = c['redis-2.2'][0]['credentials']['host']
    port = c['redis-2.2'][0]['credentials']['port']
    pass = c['redis-2.2'][0]['credentials']['password']
  rescue
    host = 'localhost'
    port = '6379'
  end

  redis = Redis.new(:host => host, :port => port, :password => pass)

  get '/' do
    @count = redis.incr 'hits'
    erb :index
  end

  get '/env' do
    res = '<pre>'
    ENV.each do |k, v|
      res << "#{k}: #{v}<br/>"
    end
    res << '</pre>'
    res
  end

  run! if app_file == $0
end

