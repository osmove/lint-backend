class AddEncryptionToCommits < ActiveRecord::Migration[5.1]
  def change

    add_column :commits, :has_encryption, :boolean
    add_column :commit_attempts, :has_encryption, :boolean

    add_column :commits, :secret_key, :string
    add_column :commit_attempts, :secret_key, :string

  end
end
