source_folder = "/home/ubuntu/SP_C2"
worker_processes 2
working_directory source_folder

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 90

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
#listen "127.0.0.1:9001", :backlog => 64
listen "#{source_folder}/tmp/sockets/unicorn.sock", :backlog => 64

pid "#{source_folder}/tmp/SP_C2_unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{source_folder}/log/unicorn.stderr.log"
stdout_path "#{source_folder}/log/unicorn.stdout.log"
