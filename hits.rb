require 'redis'
require 'sinatra'

class Hits < Sinatra::Base
  redis = Redis.new
  get '/' do
    @count = redis.incr 'hits'
    erb :index
  end
  run! if app_file == $0
end
