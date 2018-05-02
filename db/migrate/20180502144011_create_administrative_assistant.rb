class CreateAdministrativeAssistant < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_assistants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :mail_stop
      t.string :address
      t.references :administrator, foreign_key: true

      t.timestamps
    end
  end
end
