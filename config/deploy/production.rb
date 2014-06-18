set :rails_env, "production"
set :branch, "master"
set :domain, "107.170.111.27"
set :deploy_to, "/apps/#{application}"
server domain, :app, :web, :db, :primary => true
 
before "deploy:restart", "deploy:migrate"