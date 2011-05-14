# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'active_record'
#require 'mysql'
require 'pdf/toolkit'
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/config.yml')[ENV['ENV'] || 'development']
Dir['./models/**/*.rb'].each{|m| require m}

#dados = File.open('../../criativa/eleicoes2010/primeiro_turno/municipios.txt', 'r:ISO-8859-1')
dados = PDF::Toolkit.open('../../criativa/eleicoes2010/primeiro_turno/enderecos_secao.pdf')

#dados.readline
#dados.readline
#puts dados.to_text.read
i = 0
lista = []
mapa = {}
zona = nil
municipio = nil
cod_municipio = nil
bairro = nil
cod_local = nil
nome_local = nil
secoes = ''
endereco = nil
bln_pos_local = false
bln_pos_endereco = false
bln_pos_bairro = true

qtd_endereco = 0
qtd_local = 0
qtd_bairro = 0
qtd_secoes = 0

dados.to_text.each do |linha|
  #CAPTURA OS BAIRROS
  if linha =~ /^([:][\s])?([A-Z|ÁÀÃÂÉÊÍÓÔÕÚÜÇ|\'][\s]*)+/ && bln_pos_endereco
    qtd_bairro += 1
    bln_pos_endereco = false
    bln_pos_bairro = true
    bairro = linha
    #puts "#{linha.strip} #{qtd_bairro} ******#{qtd_bairro}*******"
    if (qtd_bairro != qtd_endereco)
      puts 'FALHOU'
      break
    end
    #puts secoes#.gsub(/\n/, '')
    _secoes = secoes.split(' ')
    #puts _secoes
    _secoes.each do |secao|
      _secao = secao.split('/').first
      _qtdEleitores = secao.split('/')[1]
      
      puts "secao=#{_secao} qtdEleitores=#{_qtdEleitores}"
    Localxsecao.create CodZona: zona, CodMun: cod_municipio, CodLocal: cod_local, CodSecao: _secao, QtdEleitores: _qtdEleitores
    end
    secoes = ''
    #COMO O BAIRRO E A ULTIMA COISA A SER LIDA OS REGISTROS SERÃO GRAVADOS A PARTIR DAQUI
  end
  #CAPTURA ENDEREÇO
  if linha =~ /^([:][\s])?(R.|RUA|AV.|AVENIDA|PÇ.|PRAÇA|ROD.|RODOVIA|TRAVESSA|TV.|FAZENDA|FLORES|LOCALIDADE|CÓRREGO|CASCATINHA|BR|SÃO|CLÉRIO|DISTRITO|CARAMURU|TIROL|ENCANTADO|ASSENTAMENTO|ZONA|ALAMEDA|EST.|CASCATA|LAD.|CACHOEIRA|ALDEIA|BEIRA|CABECEIRA|QD.|LOTEAMENTO|ARRAI|ALTO|VILA|SEDE|VIRGÍNIA|JATIBOCAS|SETOR)/ && bln_pos_local
  #if bln_pos_local
    qtd_endereco += 1
    bln_pos_endereco = true
    bln_pos_local = false
    endereco = linha =~ /^([:][\s])/? linha.split(':')[1] : linha
    #puts "#{linha.strip} ******#{qtd_endereco}*****"
    if (qtd_endereco != qtd_local)
      puts 'FALHOU'
      break
    end
  end
  #CAPTURA OS LOCAIS DE VOTAÇÃO
  if linha =~ /^([:][\s])?[0-9]{4,4}/ 
    _delimitador = '-' if (linha.split('-').length > 1)
    _delimitador = ' -' if (!_delimitador && linha.split(' -').length > 1)
    _delimitador = ' - ' if (!_delimitador && linha.split(' - ').length > 1)

    cod_local = linha.split(_delimitador).first
    #Limpa o nome do local
    #puts linha
    if linha.split(_delimitador).length < 2
      nome_local = linha.split(_delimitador)[1].strip
    else
      nome_local = linha.split(_delimitador)[1..linha.split(_delimitador).length - 1].join(_delimitador).strip
    end
    bln_pos_local = true
    bln_pos_bairro = false
    #puts secoes.strip
    qtd_local += 1
    #puts "cod_local=#{cod_local} nome_local=#{nome_local} *****#{qtd_local}*****"
  end
  #CAPTURA AS ZONAS ELEITORAIS
  if linha =~ /^([:][\s])?(Zona:)[\t\s][0-9]+/
    if zona != linha.split(':')[1]
      zona = linha.split(':')[1]
      #puts zona
    end
  end
  #CAPTURA AS SEÇÕES
  if linha =~ /(\d{1,3}[*]?[\/]\d{1,3}[\s])+/ && bln_pos_bairro
  #if linha =~ /^((Seção(ões)\/Aptos[\s])?[:][\s])?(\d{1,3}[*]?[\/]\d{1,3}[\s]+)/ && bln_pos_bairro
  #if linha =~ /^([:][\s])?(\d{1,3}[*]?[\/]\d{1,3})[\s\.]+/ #&& bln_pos_bairro
    if linha =~ /:/
      linha = linha.split(':')[1]
    end
    #puts linha
    _linha = linha.split("\s")
    #puts _linha
    #_secoes = _linha.collect{|a| a.split('/').first}.join("\s")
    #puts _secoes#.class
    secoes += " #{linha.strip.gsub /\n/, ' '}"
    qtd_secoes += 1
  end
  
  if linha =~ /^([:][\s])?(Município:)/
    if municipio != linha.split('-')[1]
      cod_municipio = linha.split('-').first
      municipio = linha.split('-')[1]
      #i += 1
      #puts municipio
    end
  end
  #puts linha
  

  #forma mais demorada, porém mais correta ->
  #if linha =~ /^([:][\s])?([A-Z|ÁÀÃÂÉÊÍÓÔÕÚÜÇ]+[\s]*)+$/ #&& blnDepoisEndereco
  #Encontra Endereços
  #if linha =~ /^(Munic[.]+:)/
    #puts linha
  #end
    
    #Limpa o nome do local
    #mapa[:nomeLocal] = linha.split('-')[1].strip
    #puts "**************#{mapa[:codLocal]}**************"
    #puts "**************#{mapa[:nomeLocal]}**************"
  #lista << mapa
  #else
    #puts linha
  #TODO Encontrar padrões de regexp p/ o codMun, secoes, codZona, nomeBairro e endLocal
end
puts "qtd_endereco = #{qtd_endereco} qtd_bairro=#{qtd_bairro} qtd_local=#{qtd_local} qtd_secoes=#{qtd_secoes}"
#puts lista
#dados.each do |linha| 
  ##begin

    #puts linha
    ##v = linha.split(' ')
    ##puts "inserindo municipio #{v.second} de cod #{v.first}"
    ##Municipio.create CodMun: v.first, NomMun: v.second
  ##rescue Mysql::Error => e
    ##puts "#{e.class}: #{e.message}"
  ##end
#end

#puts Municipio.count


