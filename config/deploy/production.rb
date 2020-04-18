# server '18.178.57.8', user: 'app', roles: %w{app db web}
#set :ssh_options, keys: '/Users/yotanaka/.ssh/id_rsa'

server '18.178.57.8',
   user: "app",
   roles: %w{web db app},
   ssh_options: {
       #port: 22022,
       #user: "odatakashi", # overrides user setting above
       keys: '/Users/yotanaka/.ssh/id_rsa',
       forward_agent: true
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
   }