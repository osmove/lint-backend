class AddFieldsToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :to_name, :string
    add_column :messages, :to_email, :string
    add_column :messages, :subject, :string
    add_column :messages, :origin, :string
    add_column :messages, :provider, :string
  end
end
