pwd         = File.expand_path('../../../', __FILE__)
tmp_path    = File.join(pwd, 'tmp')
socket_path = "/tmp/unicorn.sock"
pid_path    = File.join(tmp_path, 'unicorn.pid')
log_path    = File.join(pwd, 'log')
err_path    = File.join(log_path, 'error.log')
out_path    = File.join(log_path, 'out.log')

# Make sure this exists.
unless Dir.exists?(tmp_path)
  Dir.mkdir(tmp_path)
end

unless Dir.exists?(log_path)
  Dir.mkdir(log_path)
end

worker_processes 1
working_directory pwd
preload_app true

listen ENV['PORT'], :tcp_nopush => true

timeout 30
pid pid_path

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  sleep 1
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
