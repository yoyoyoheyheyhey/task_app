server '18.178.57.8', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/yotanaka/.ssh/id_rsa'