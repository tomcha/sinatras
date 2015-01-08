require 'sinatra/base'
require 'haml'

class Hoge< Sinatra::Base
  get '/' do
    haml :index
  end
end
