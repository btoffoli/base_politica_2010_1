# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'active_record'
#require 'mysql'
require 'pdf/toolkit'
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/config.yml')[ENV['ENV'] || 'development']
Dir['./models/**/*.rb'].each{|m| require m}

#dados = File.open('../../criativa/eleicoes2010/primeiro_turno/municipios.TXT', 'r:ISO-8859-1')
dados = PDF::Toolkit.open('../../criativa/eleicoes2010/primeiro_turno/resultado-votacao-uf.pdf')

qtd_presidente = 0
qtd_senador = 0
qtd_governador = 0
qtd_dep_federal = 0
qtd_dep_estadual = 0
cod_partido = nil
cargo = nil
cod_cargo = nil
nome_cand = nil
cod_cand = nil
bln_pos_pres_sen = false
dados.to_text.each do |linha|
  #puts linha
  if linha =~ /^(Cargo:)[\s][A-Za-z]+/
    cargo = linha.split(':')[1].strip
    #puts cargo
  end
  if linha =~ /^[*]?[0-9]{2,5}[\s](-)[\s][A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+/
    if linha =~ /^[*]/
      linha = linha.split('*').second
    end
    puts linha
    cod_cand = linha.split('-').first.strip
    cod_partido = cod_cand[0..1]
    nome_cand = linha.split('-').second.strip
    if linha =~ /^[*]?[0-9]{2}[\s](-)[\s][A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+/
      qtd_presidente += 1
      bln_pos_pres_sen = true
    end
    if linha =~ /^[*]?[0-9]{3}[\s](-)[\s][A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+/
      qtd_senador += 1
    end
    if linha =~ /^[*]?[0-9]{4}[\s](-)[\s][A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+/
      qtd_dep_federal+= 1
    end
    if linha =~ /^[*]?[0-9]{5}[\s](-)[\s][A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+/
      qtd_dep_estadual += 1
    end
    case cargo
    when 'Presidente'
      cod_cargo = 1
    when 'Governador'
      cod_cargo = 3
    when 'Senador'
      cod_cargo = 5
    when 'Deputado Federal'
      cod_cargo = 6
    when 'Deputado Estadual'
      cod_cargo = 7
    end
    puts "cod_cargo=#{cod_cargo} cod_partido=#{cod_partido} cod_cand=#{cod_cand} nome_cand=#{nome_cand}"

    Candidato.create NumCand: cod_cand, CodCargo: cod_cargo, NumPartido: cod_partido, NomCand: nome_cand
  end
  if linha =~ /^[A-ZÁÀÃÂÉÊÍÓÔÕÚÜÇ' ']+$/ && bln_pos_pres_sen
    _cod_cargo = nil
    puts linha
    bln_pos_pres_sen = false
    case cargo
    when 'Presidente'
      _cod_cargo = 2
    when 'Governador'
      _cod_cargo = 4
    end
    puts _cod_cargo 
  end
end
puts "qtd_presidente=#{qtd_presidente} qtd_senador=#{qtd_senador} qtd_dep_federal=#{qtd_dep_federal} qtd_dep_estadual=#{qtd_dep_estadual}"
