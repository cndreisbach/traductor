ActiveRecord::Schema.define do
  create_table "oficinas_de_turismo" do |t|
    t.string "nombre"
    t.string "calle"
  end
  
  create_table "snippets" do |t|
    t.string "name"
    t.string "en_text"
    t.string "es_text"
  end
  
  create_table "sites" do |t|
    t.string "name"
    t.text "description"
    t.string "city"
  end
  
  create_table "translations" do |t|
    t.references 'source', :polymorphic => true
    t.string 'locale'
    t.text 'fields'
  end
end
