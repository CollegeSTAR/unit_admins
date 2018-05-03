class AddTypeToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_column :administrators, :type, :string
    add_index :administrators, :type
  end
end
