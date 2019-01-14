class AddRawContentToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :sub_type, :string
    add_column :documents, :sub_sub_type, :string
    add_column :documents, :raw_content, :text
    add_column :documents, :base_64_content, :text
  end
end
