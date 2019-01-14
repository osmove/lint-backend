class CreateBuildpacks < ActiveRecord::Migration[5.1]
  def change
    create_table :buildpacks do |t|
      t.string :name
      t.string :web_address
      t.string :git_address
      t.references :command, foreign_key: true
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
