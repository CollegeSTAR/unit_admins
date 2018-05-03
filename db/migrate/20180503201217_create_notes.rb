class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :text
      t.references :institution, foreign_key: true
      t.references :institutional_unit, foreign_key: true
      t.references :department, foreign_key: true
      t.references :administrator, foreign_key: true

      t.timestamps
    end
  end
end
