class AddCurrentToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_column :administrators, :current, :boolean, default: false
  end
end
