class AddDepartmentReferenceToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_reference :administrators, :department, foreign_key: true
  end
end
