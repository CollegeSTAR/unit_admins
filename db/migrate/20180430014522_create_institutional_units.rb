class CreateInstitutionalUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :institutional_units do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :institutional_units, :slug, unique: true
  end
end
