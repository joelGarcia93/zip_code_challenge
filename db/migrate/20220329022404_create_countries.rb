class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false # 3 characteres
      t.string :code2, null: false # 2 characteres
      t.string :description, null: true
      t.index :name, unique: true
      t.index :code, unique: true
    end
  end
end
