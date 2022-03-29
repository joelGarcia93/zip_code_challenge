class CreateMunicipalities < ActiveRecord::Migration[5.2]
  def change
    create_table :municipalities do |t|
      t.references :state, type: :string, foreign_key: true, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: true
      t.index [:state_id, :code], unique: true
    end
  end
end
