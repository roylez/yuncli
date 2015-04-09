desc 'run all the test cases'
task :test do
  sh 'NO_TYPHOEUS=1 bundle exec rspec spec/connection/net_http_spec.rb'
  sh 'bundle exec rspec spec/connection/typhoeus_spec.rb'
end

task :default => :test
