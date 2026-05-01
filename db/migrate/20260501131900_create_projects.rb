class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :status, null: false, default: 'active'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :projects, %i[user_id slug], unique: true
    add_reference :repositories, :project, foreign_key: true
  end
end
