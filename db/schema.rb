# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "Brancos", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "CodLocal"
    t.float   "TotVotos"
  end

  add_index "Brancos", ["CodMun"], :name => "CodMun"

  create_table "Candidato", :id => false, :force => true do |t|
    t.integer "CodMun",                 :default => 0
    t.integer "NumCand"
    t.integer "CodCargo"
    t.string  "NomCand",  :limit => 70
    t.string  "NomUrna",  :limit => 30
    t.integer "Situacao"
  end

  add_index "Candidato", ["CodCargo"], :name => "CodCargo"
  add_index "Candidato", ["CodMun"], :name => "CodMun"

  create_table "Candidatos", :id => false, :force => true do |t|
    t.integer "NumCand",                                 :null => false
    t.integer "CodCargo",                                :null => false
    t.integer "NumPartido",               :default => 0, :null => false
    t.string  "NomCand",    :limit => 70
    t.string  "NomUrna",    :limit => 50
  end

  add_index "Candidatos", ["CodCargo", "NumCand"], :name => "cargo"
  add_index "Candidatos", ["CodCargo"], :name => "CodCargo"
  add_index "Candidatos", ["CodCargo"], :name => "CodCargo_2"
  add_index "Candidatos", ["NomCand"], :name => "nome"

  create_table "CandxEstado", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.integer "NumCand"
    t.float   "TotVotos"
  end

  add_index "CandxEstado", ["CodCargo"], :name => "CodCargo"

  create_table "CandxLocal", :id => false, :force => true do |t|
    t.integer "CodMun",     :null => false
    t.integer "CodZona",    :null => false
    t.integer "CodLocal",   :null => false
    t.integer "CodCargo",   :null => false
    t.integer "NumCand",    :null => false
    t.integer "TotVotos"
    t.integer "NumPartido", :null => false
  end

  add_index "CandxLocal", ["CodCargo", "NumCand", "NumPartido"], :name => "CodCargo_2"
  add_index "CandxLocal", ["CodCargo"], :name => "CodCargo"
  add_index "CandxLocal", ["CodMun", "CodZona", "CodLocal"], :name => "CodMun_2"
  add_index "CandxLocal", ["CodMun"], :name => "CodMun"
  add_index "CandxLocal", ["CodZona", "CodMun", "CodLocal"], :name => "CodZona"
  add_index "CandxLocal", ["NumCand", "CodCargo", "NumPartido"], :name => "NumCand"

  create_table "CandxMunic", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodCargo"
    t.integer "NumCand"
    t.integer "NumPartido"
    t.integer "TotVotos"
  end

  add_index "CandxMunic", ["CodMun"], :name => "CodMun"

  create_table "CandxSituacao", :id => false, :force => true do |t|
    t.integer "NumCand"
    t.integer "CodCargo"
    t.string  "NomCand",    :limit => 70
    t.string  "NomUrna",    :limit => 50
    t.integer "Situacao"
    t.integer "NumPartido"
  end

  create_table "CandxZona", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "NumCand"
    t.float   "TotVotos"
  end

  create_table "Cargos", :primary_key => "CodCargo", :force => true do |t|
    t.string  "NomCargo",    :limit => 50
    t.integer "TipoEleicao",               :default => 0
  end

  add_index "Cargos", ["CodCargo"], :name => "CodCargo"

  create_table "Coligacoes", :id => false, :force => true do |t|
    t.string  "NomCol",     :limit => 84
    t.integer "CodCargo"
    t.integer "NumPartido"
    t.string  "Composicao", :limit => 100
  end

  add_index "Coligacoes", ["CodCargo"], :name => "CodCargo"

  create_table "ColxEstado", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.float   "TotVotos"
    t.float   "Legenda"
    t.float   "Nominal"
  end

  add_index "ColxEstado", ["CodCargo"], :name => "CodCargo"

  create_table "ColxEstadoComLegenda", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.float   "TotVotos"
    t.float   "Legenda"
  end

  create_table "ColxLocal", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodMun"
    t.integer "CodLocal"
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.integer "TotVotos"
  end

  add_index "ColxLocal", ["CodCargo"], :name => "CodCargo"
  add_index "ColxLocal", ["CodZona", "CodMun", "CodLocal"], :name => "CodZona"

  create_table "ColxMunic", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.integer "TotVotos"
  end

  add_index "ColxMunic", ["CodCargo"], :name => "CodCargo"
  add_index "ColxMunic", ["CodMun"], :name => "CodMun"

  create_table "ColxMunicComLegenda", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.float   "TotVotos"
    t.float   "Legenda"
  end

  create_table "ColxZona", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodCargo"
    t.string  "NomCol",   :limit => 84
    t.float   "TotVotos"
  end

  create_table "Locais", :id => false, :force => true do |t|
    t.integer "CodZona",  :null => false
    t.integer "CodMun",   :null => false
    t.integer "CodLocal", :null => false
    t.string  "NomLocal"
    t.string  "Endereco"
    t.string  "Bairro"
    t.string  "Secoes"
  end

  add_index "Locais", ["CodMun"], :name => "CodMun"

  create_table "LocaisOld", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodLocal"
    t.string  "NomLocal"
    t.string  "EndLocal", :limit => 100
    t.string  "Bairro",   :limit => 100
    t.string  "CEP",      :limit => 50
    t.string  "Secoes"
  end

  create_table "LocalxSecao", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodSecao"
    t.integer "CodLocal"
    t.integer "QtdEleitores"
    t.integer "CodSecaoPrincipal"
  end

  create_table "Municipios", :primary_key => "CodMun", :force => true do |t|
    t.string "NomMun", :limit => 50
  end

  create_table "Nulos", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "CodLocal"
    t.float   "TotVotos"
  end

  create_table "NulosAInserir", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodSecao"
    t.integer "CodCargo"
    t.integer "CodLocal"
    t.integer "TotVotos"
    t.integer "NumVotavel"
  end

  create_table "Partidos", :primary_key => "NumPartido", :force => true do |t|
    t.string "SiglaPartido", :limit => 13
    t.string "NomPartido",   :limit => 50
  end

  create_table "PartidosIsolados", :id => false, :force => true do |t|
    t.integer "NumPartido",                                :null => false
    t.integer "CodCargo",                   :default => 0, :null => false
    t.string  "SiglaPartido", :limit => 13
    t.string  "NomPartido",   :limit => 50
  end

  create_table "PartxEstado", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.integer "NumPartido"
    t.float   "TotVotos"
    t.float   "Legenda"
    t.float   "Nominal"
  end

  create_table "PartxEstadoComLegenda", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.float   "TotVotos"
    t.integer "NumPartido"
    t.float   "Legenda"
  end

  create_table "PartxLocal", :id => false, :force => true do |t|
    t.integer "NumPartido"
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "CodLocal"
    t.float   "TotVotos"
  end

  create_table "PartxMunic", :id => false, :force => true do |t|
    t.integer "NumPartido"
    t.integer "CodMun"
    t.integer "CodCargo"
    t.integer "TotVotos"
  end

  create_table "PartxZona", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "NumPartido"
    t.float   "TotVotos"
  end

  create_table "Resultados", :id => false, :force => true do |t|
    t.integer "NumCand",  :default => 0, :null => false
    t.integer "CodCargo", :default => 0, :null => false
    t.float   "Votos"
  end

  add_index "Resultados", ["NumCand", "CodCargo"], :name => "primario", :unique => true

  create_table "ResultadosPorBairro", :id => false, :force => true do |t|
    t.integer "NumCand",   :default => 0,  :null => false
    t.integer "codCargo",  :default => 0,  :null => false
    t.integer "codMun",    :default => 0,  :null => false
    t.string  "bairro",    :default => "", :null => false
    t.float   "qtdeVotos"
  end

  add_index "ResultadosPorBairro", ["NumCand", "codCargo", "codMun", "bairro"], :name => "tudo", :unique => true
  add_index "ResultadosPorBairro", ["bairro"], :name => "bairro"

  create_table "ResultadosPorMunicipio", :id => false, :force => true do |t|
    t.integer "numCand",   :default => 0, :null => false
    t.integer "codCargo",  :default => 0, :null => false
    t.integer "codMun",    :default => 0, :null => false
    t.float   "qtdeVotos"
  end

  add_index "ResultadosPorMunicipio", ["numCand", "codCargo", "codMun"], :name => "primario", :unique => true

  create_table "Secoes", :id => false, :force => true do |t|
    t.integer "CodMun",            :default => 0, :null => false
    t.integer "CodZona",                          :null => false
    t.integer "CodSecao",                         :null => false
    t.integer "QtdEleitores"
    t.integer "CodSecaoPrincipal"
    t.integer "CodLocal",          :default => 0
  end

  create_table "SituacaoCand", :id => false, :force => true do |t|
    t.integer "NumCand",  :null => false
    t.integer "CodCargo", :null => false
    t.integer "Situacao"
  end

  create_table "Situacoes", :primary_key => "CodSituacao", :force => true do |t|
    t.string "Situacao", :limit => 50
  end

  add_index "Situacoes", ["CodSituacao"], :name => "CodSituacao"

  create_table "Situacoes_Desc", :primary_key => "CodSituacao", :force => true do |t|
    t.string "Situacao", :limit => 50
  end

  add_index "Situacoes_Desc", ["CodSituacao"], :name => "CodSituacao"

  create_table "Teste", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodSecao"
    t.integer "CodCargo"
    t.integer "NumVotavel"
    t.integer "CodLocal"
    t.float   "TotVotos"
  end

  create_table "TotEstado", :id => false, :force => true do |t|
    t.integer "CodCargo"
    t.float   "TotVotos"
    t.float   "Brancos"
    t.float   "Nulos"
  end

  create_table "TotLocal", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodMun"
    t.integer "CodLocal"
    t.integer "CodCargo"
    t.float   "TotVotos"
    t.float   "Brancos"
    t.float   "Nulos"
  end

  create_table "TotMunic", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodCargo"
    t.float   "TotVotos"
    t.float   "Brancos"
    t.float   "Nulos"
  end

  create_table "TotZona", :id => false, :force => true do |t|
    t.integer "CodZona"
    t.integer "CodCargo"
    t.integer "TotVotos"
    t.integer "Brancos"
    t.integer "Nulos"
  end

  create_table "Votacao", :id => false, :force => true do |t|
    t.integer "CodMun",     :default => 0, :null => false
    t.integer "CodZona",                   :null => false
    t.integer "CodSecao",                  :null => false
    t.integer "CodCargo",                  :null => false
    t.integer "NumVotavel",                :null => false
    t.integer "CodLocal",   :default => 0
    t.integer "TotVotos"
    t.integer "numCand"
  end

end
