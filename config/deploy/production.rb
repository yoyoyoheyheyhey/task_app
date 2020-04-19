server '18.178.57.8', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/yotanaka/.ssh/id_rsa'

set :assets_roles, [:web, :app]
server '18.178.57.8', roles: %w(web app)


# Defaults to 'assets'
# This should match config.assets.prefix in your rails config/application.rb
set :assets_prefix, 'prepackaged-assets'

# Defaults to ["/path/to/release_path/public/#{fetch(:assets_prefix)}/.sprockets-manifest*", "/path/to/release_path/public/#{fetch(:assets_prefix)}/manifest*.*"]
# This should match config.assets.manifest in your rails config/application.rb
set :assets_manifests, ['app/assets/config/manifest.js']

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
set :rails_assets_groups, :assets

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
set :keep_assets, 2
# server '18.178.57.8',
#    user: "app",
#    roles: %w{web db app},
#    ssh_options: {
#        #port: 22022,
#        #user: "odatakashi", # overrides user setting above
#        keys: '/Users/yotanaka/.ssh/id_rsa',
#        forward_agent: true
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
  #  }