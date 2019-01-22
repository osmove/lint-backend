class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :message
      t.string :type
      t.string :status
      t.boolean :read
      t.references :user, foreign_key: true
      t.references :lead, foreign_key: true

      t.timestamps
    end
  end
end
