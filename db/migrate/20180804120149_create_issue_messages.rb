class CreateIssueMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_messages do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :username
      t.references :issue, foreign_key: true
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
