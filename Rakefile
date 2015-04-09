desc 'run all the test cases'
task :test do
  sh 'bundle exec rspec spec/connection/typhoeus_spec.rb spec/integration/'
  sh 'NO_TYPHOEUS=1 bundle exec rspec spec/connection/net_http_spec.rb spec/integration/'
end

task :default => :test
