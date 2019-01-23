class AddRawToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :raw_post, :text
  end
end
