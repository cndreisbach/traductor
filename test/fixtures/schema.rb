ActiveRecord::Schema.define do
  create_table "oficinas_de_turismo" do |t|
    t.column "nombre", :string
    t.column "calle", :string
  end
end
