class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states, id: :string do |t|
      t.references :country, foreign_key: true, null: false
      t.string :code, null: true # 3 characteres
      t.string :code2, null: false # 2 characteres
      t.string :name, null: false
      t.string :description, null: true
      t.index :name, unique: true
      t.index :code2, unique: true
    end
  end
end
