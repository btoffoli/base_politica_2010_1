require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'mysql'
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/config.yml')[ENV['ENV'] || 'development']
Dir['./models/**/*.rb'].each{|m| require m}

dados = File.open('../../criativa/eleicoes2010/primeiro_turno/municipios.txt', 'r:ISO-8859-1')

dados.readline
dados.readline

dados.each do |linha| 
  begin

    puts linha
    v = linha.split(' ')
    puts "inserindo municipio #{v[1..v.size].join(' ')} de cod #{v.first}"
    Municipio.create CodMun: v.first, NomMun: v[1..v.size].join(' ')
  rescue Mysql::Error => e
    puts "#{e.class}: #{e.message}"
  end
end

puts Municipio.count


