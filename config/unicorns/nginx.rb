pwd         = File.expand_path('../../../../current', __FILE__)
tmp_path    = File.join(pwd, 'tmp')
pid_path    = File.join(tmp_path, 'unicorn.pid')
log_path    = File.join(pwd, 'log')
err_path    = File.join(log_path, 'error.log')
out_path    = File.join(log_path, 'out.log')

socket_path = "/tmp/unicorn.sock"

# Make sure this exists.
unless Dir.exists?(tmp_path)
  Dir.mkdir(tmp_path)
end

unless Dir.exists?(log_path)
  Dir.mkdir(log_path)
end

worker_processes 4
working_directory pwd
preload_app true

listen socket_path, backlog: 64

# NOTE: We're temporarily removing timeouts for web requests while we work
# through the contention issues we're seeing against the data pipeline. Bear
# with us.
#
#timeout 30
pid pid_path

stderr_path err_path
stdout_path out_path

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{pwd}/Gemfile"
end

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  # Now that everything is reconnected, let's start the process of rolling the
  # new unicorn.
  old_pid ="#{server.config[:pid]}.oldbin"

  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # TODO: Log this?
    end
  end

  sleep 1
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
