require 'httparty'

class GigJunkie
  include HTTParty
  base_uri 'http://api.gigjunkie.net/v1.0/'
  
  # options - pageIndex, pageSize, latitude, longitude, distance, genre
  SORT_BY = %w{date distance}
  GENRES = %w{rock-pop country-folk rap-hip-hop jazz-blues world alternative-indie hard-rock-metal clubs-dance r-and-b-urban-soul tribute-bands}
  
  def initialize api_key
    @api_key = api_key
    @default_options = {:query => {:consumerKey => @api_key}}
  end
  
  def merge_query_options(options)
    options = @default_options.merge(:query => @default_options[:query].merge(options))
  end
  
  def events(options = {})
    options = merge_query_options(options)
    self.class.get('/events', options)['response']['events']['event']
  end
  
  def hot_events(options)
    raise "options must contain latitute, longtitude and distance for hot_events" unless [:latitude, :longitude, :distance].all?{|x| options.include? x}
    options = merge_query_options(options)
    self.class.get('/hot-events', options)['response']['events']['event']
  end
  
  def hot_artists(options = {})
    raise "options must contain latitute, longtitude and distance for hot_events" unless [:latitude, :longitude, :distance].all?{|x| options.include? x}
    options = merge_query_options(options)
    self.class.get('/hot-artists', options)['response']['artists']['artist']
  end
end