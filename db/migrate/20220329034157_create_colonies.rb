class CreateColonies < ActiveRecord::Migration[5.2]
  def change
    create_table :colonies do |t|
      t.references :zip_code, type: :string, foreign_key: true, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: true
      t.index [:name, :code, :zip_code_id], unique: true, name: 'idx_on_name_code_and_postal_code_id'
    end
  end
end
