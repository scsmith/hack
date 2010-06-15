begin
  # Require the preresolved locked set of gems.
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

require 'sinatra/base'
require 'sinatra_more/markup_plugin'
require 'HTTParty'
require 'json'
require 'haml'

class AuthServer < Sinatra::Base
  register SinatraMore::MarkupPlugin
  #register SinatraMore::RenderPlugin
  #register SinatraMore::WardenPlugin
  #register SinatraMore::MailerPlugin
  #register SinatraMore::RoutingPlugin
  
  configure do
    set :sessions, true
    set :public, ::File.dirname(__FILE__) + '/public'
    set :views, ::File.dirname(__FILE__) + '/views'
    set :sass, {:style => :compressed }
  end
  
  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  get '/' do
    haml :index, :layout => false
  end
end

run AuthServer