class AddInstitutionReferenceToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_reference :administrators, :institution, foreign_key: true
  end
end
