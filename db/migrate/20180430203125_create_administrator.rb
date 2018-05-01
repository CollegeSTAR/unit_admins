class CreateAdministrator < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :job_title
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :mail_stop
      t.string :sec_loc
      t.boolean :interim

      t.timestamps
    end
  end
end
