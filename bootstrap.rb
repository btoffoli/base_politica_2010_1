require 'rubygems'
require 'bundler/setup'
require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/config.yml')[ENV['ENV'] || 'development']
Dir['./models/**/*.rb'].each{|m| require m}
Municipio.create CodMun: 56003, NomMun: 'teste'
puts Municipio.count
# call some useful code here
