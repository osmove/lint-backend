class CreateLinters < ActiveRecord::Migration[5.1]
  def change
    create_table :linters do |t|
      t.string :name

      t.timestamps
    end

    add_reference :rules, :linter, foreign_key: true

  end
end
