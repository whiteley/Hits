require 'redis'
require 'sinatra'

class Hits < Sinatra::Base

  configure do
    set :root, File.expand_path(File.dirname(__FILE__))
  end

  before do
    @redis = Redis.new
  end

  get '/' do
    @count = @redis.incr 'hits'
    erb :index
  end

  run! if app_file == $0

end
