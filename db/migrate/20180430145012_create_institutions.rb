class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :institutions, :slug, unique: true
  end
end
