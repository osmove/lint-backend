class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :title
      t.text :message
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
