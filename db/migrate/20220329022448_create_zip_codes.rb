class CreateZipCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :zip_codes, id: :string do |t|
      t.references :municipality, foreign_key: true, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: true
      t.index :name, unique: true
      t.index :code, unique: true
    end
  end
end
