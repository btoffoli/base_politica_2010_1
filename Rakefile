#begin
  #require 'tasks/standalone_migrations'
  #MigratorTasks.new
#rescue LoadError => e
  #puts "You should run 'bundle' first"
  #end
  #
begin
  require 'tasks/standalone_migrations'
  MigratorTasks.new do |t|
    t.migrations = "db/migrations"
    t.config = "db/config.yml"
    t.schema = "db/schema.rb"
    t.env = "production"
     #TODO: figure out why this property went away
    t.verbose = true
    t.log_level = Logger::DEBUG
  end
  #configure :production do
    #set :environment, :production
    #t.env = "production"
  #end
rescue LoadError => e
  puts "gem install standalone_migrations to get db:migrate:* tasks! (Error: #{e})"
end

