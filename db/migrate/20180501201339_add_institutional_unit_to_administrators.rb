class AddInstitutionalUnitToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_reference :administrators, :institutional_unit, foreign_key: true
  end
end
