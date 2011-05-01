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

ActiveRecord::Schema.define(:version => 20110411023626) do

  create_table "Brancos", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodLocal"
    t.integer "CodCargo"
    t.integer "NumPartido"
    t.integer "TotVotos"
  end

  create_table "Candidato", :id => false, :force => true do |t|
    t.integer "CodMun",                 :default => 0, :null => false
    t.integer "NumCand",                               :null => false
    t.integer "CodCargo",                              :null => false
    t.string  "NomCand",  :limit => 70
    t.string  "NomUrna",  :limit => 50
    t.integer "Situacao"
  end

  add_index "Candidato", ["CodCargo"], :name => "CodCargo"
  add_index "Candidato", ["NomUrna"], :name => "nome"
  add_index "Candidato", ["NumCand", "CodCargo"], :name => "cand"

  create_table "Candidatos", :id => false, :force => true do |t|
    t.integer "CodMun",                 :default => 0, :null => false
    t.integer "NumCand",                               :null => false
    t.integer "CodCargo",                              :null => false
    t.string  "NomCand",  :limit => 70
    t.string  "NomUrna",  :limit => 50
    t.integer "Situacao"
  end

  add_index "Candidatos", ["CodCargo"], :name => "CodCargo"
  add_index "Candidatos", ["NomUrna"], :name => "nome"
  add_index "Candidatos", ["NumCand", "CodCargo"], :name => "cand"

  create_table "CandxLocal", :id => false, :force => true do |t|
    t.integer "CodZona",                   :null => false
    t.integer "CodMun",                    :null => false
    t.integer "CodLocal",                  :null => false
    t.integer "CodCargo",                  :null => false
    t.integer "NumCand",                   :null => false
    t.integer "NumPartido", :default => 0
    t.integer "TotVotos"
  end

  add_index "CandxLocal", ["NumCand", "CodMun"], :name => "NumCand"

  create_table "CandxMunic", :id => false, :force => true do |t|
    t.integer "CodMun",     :null => false
    t.integer "CodCargo",   :null => false
    t.integer "NumCand",    :null => false
    t.integer "NumPartido"
    t.integer "TotVotos"
  end

  create_table "CandxSituacao", :id => false, :force => true do |t|
    t.integer "CodMun",                 :default => 0, :null => false
    t.integer "NumCand",                               :null => false
    t.integer "CodCargo",                              :null => false
    t.string  "NomCand",  :limit => 70
    t.string  "NomUrna",  :limit => 50
    t.integer "Situacao"
  end

  add_index "CandxSituacao", ["CodCargo"], :name => "CodCargo"
  add_index "CandxSituacao", ["NomUrna"], :name => "nome"
  add_index "CandxSituacao", ["NumCand", "CodCargo"], :name => "cand"

  create_table "Cargos", :primary_key => "CodCargo", :force => true do |t|
    t.string  "NomCargo",    :limit => 50
    t.integer "TipoEleicao",               :default => 0
  end

  add_index "Cargos", ["CodCargo"], :name => "CodCargo"

  create_table "Coligacoes", :id => false, :force => true do |t|
    t.integer "CodMun",                   :default => 0, :null => false
    t.string  "NomCol",     :limit => 84,                :null => false
    t.integer "CodCargo",                                :null => false
    t.integer "NumPartido",                              :null => false
  end

  create_table "Locais", :id => false, :force => true do |t|
    t.integer "CodZona",                 :default => 0
    t.integer "CodMun",                  :default => 0
    t.integer "CodLocal",                :default => 0
    t.string  "NomLocal"
    t.string  "Secoes"
    t.string  "Bairro",   :limit => 100
    t.string  "EndLocal", :limit => 100
  end

  add_index "Locais", ["CodMun"], :name => "CodMun"

  create_table "LocalxSecao", :id => false, :force => true do |t|
    t.integer "CodMun",            :default => 0, :null => false
    t.integer "CodZona",                          :null => false
    t.integer "CodSecao",                         :null => false
    t.integer "CodLocal",          :default => 0, :null => false
    t.integer "QtdEleitores"
    t.integer "CodSecaoPrincipal"
  end

  create_table "Municipios", :primary_key => "CodMun", :force => true do |t|
    t.string "NomMun", :limit => 50
  end

  create_table "Nulos", :id => false, :force => true do |t|
    t.integer "CodMun",     :null => false
    t.integer "CodZona",    :null => false
    t.integer "CodLocal",   :null => false
    t.integer "CodCargo",   :null => false
    t.integer "NumPartido"
    t.float   "TotVotos"
  end

  create_table "Partidos", :primary_key => "NumPartido", :force => true do |t|
    t.string "SiglaPartido", :limit => 13
    t.string "NomPartido",   :limit => 50
  end

  create_table "Resultados", :id => false, :force => true do |t|
    t.integer "CodMun",   :default => 0, :null => false
    t.integer "NumCand",  :default => 0, :null => false
    t.integer "CodCargo", :default => 0, :null => false
    t.float   "Votos"
  end

  add_index "Resultados", ["CodMun", "NumCand", "CodCargo"], :name => "primario", :unique => true

  create_table "ResultadosPorBairro", :id => false, :force => true do |t|
    t.integer "NumCand",                  :default => 0,  :null => false
    t.integer "codCargo",                 :default => 0,  :null => false
    t.integer "codMun",                   :default => 0,  :null => false
    t.string  "bairro",    :limit => 100, :default => "", :null => false
    t.float   "qtdeVotos"
  end

  add_index "ResultadosPorBairro", ["NumCand", "codCargo", "codMun", "bairro"], :name => "primario", :unique => true
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

  add_index "Secoes", ["CodMun", "CodLocal"], :name => "CodMun_2"
  add_index "Secoes", ["CodMun"], :name => "CodMun"

  create_table "TotLocal", :id => false, :force => true do |t|
    t.integer "CodMun"
    t.integer "CodZona"
    t.integer "CodLocal"
    t.integer "CodCargo"
    t.integer "TotVotos"
    t.integer "Brancos"
    t.float   "Nulos"
  end

end
