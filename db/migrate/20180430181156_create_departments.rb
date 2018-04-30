class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :slug
      t.references :institution, foreign_key: true
      t.references :institutional_unit, foreign_key: true
      
      t.timestamps
    end

    add_index :departments, :slug, unique: true
  end
end
