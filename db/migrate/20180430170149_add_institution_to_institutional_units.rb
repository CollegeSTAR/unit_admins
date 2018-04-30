class AddInstitutionToInstitutionalUnits < ActiveRecord::Migration[5.2]
  def change
    add_reference :institutional_units, :institution, foreign_key: true
  end
end
