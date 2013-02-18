VCR.configure do |c|
# uri: http://webservices.amazon.com/onca/xml?
  # AWSAccessKeyId = 12VVZFFGCXXK8A0B40G2&
  # AssociateTag   = wwwjefferso02-20&
  # Keywords       = 0321659368&
  # Operation      = ItemSearch&
  # ResponseGroup  = Medium&
  # SearchIndex    = Books&
  # Service        = AWSECommerceService&
  # Signature      = x7bpGZJWKuqWsFkpYwstJJ2GeQeXXmU3pmEb6JIcZbM = &
  # Timestamp      = 2013-01-01T20:58:02Z&
  # Version        = 2011-08-01

  c.ignore_request do |request|
    uri = URI(request.uri)
    matcher = MatchURI.new(uri)
    matcher.has_matches?
  end

  c.default_cassette_options = { :record => :new_episodes, :match_requests_on => [VCR.request_matchers.uri_without_params(:Timestamp, :Signature), :method] }
  c.cassette_library_dir  = 'spec/vcr/cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
end

class MatchURI

  attr_reader :matches, :uri

  def initialize(uri)
    @uri = uri
    @matches = [
      lambda {|uri| uri.host == 'localhost' || uri.host == '127.0.0.1'},
      lambda {|uri| uri.host == 'localhost' && uri.port == 9200},
      lambda {|uri| uri.path == '/__identify__'},
      lambda {|uri| uri.host == '127.0.0.1' && /\/hub\/session.*/.match(uri.path)}
    ]
  end

  def has_matches?
    matches.each do |l|
      return true if l.call(uri)
    end
    return false
  end
end
