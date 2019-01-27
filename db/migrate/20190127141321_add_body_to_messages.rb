class AddBodyToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :html_body, :text
    rename_column :messages, :message, :text_body
  end
end
