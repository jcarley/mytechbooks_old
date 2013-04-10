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

  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { :record => :new_episodes, :match_requests_on => [VCR.request_matchers.uri_without_params(:Timestamp, :Signature), :method] }
  c.cassette_library_dir  = 'features/vcr/cassettes'
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', :use_scenario_name => true
end
