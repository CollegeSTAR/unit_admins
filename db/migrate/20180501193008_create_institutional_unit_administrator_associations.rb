class CreateInstitutionalUnitAdministratorAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :institutional_unit_administrator_associations do |t|
      t.references :institutional_unit, foreign_key: true, index: { name: 'index_unit_admin_assoc_unit_id' }
      t.references :administrator, foreign_key: true, index: { name: 'index_unit_admin_assoc_admin_id' }

      t.timestamps
    end
  end
end
