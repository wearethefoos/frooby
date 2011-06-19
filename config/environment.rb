# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('lib/authentication.rb');
require File.expand_path('lib/embedded_document_callbacks.rb');

Mongo::Application.configure do |config|
  config.gem 'thoughtbot-shoulda', :lib => 'shoulda/rails', :source => "http://gems.github.com"
  config.gem 'factory_girl'
  config.gem 'mocha'
  config.gem 'redgreen'
  config.gem 'mongo_mapper'
  #config.frameworks -= [:active_record]
end

# Initialize the rails application
Mongo::Application.initialize!
