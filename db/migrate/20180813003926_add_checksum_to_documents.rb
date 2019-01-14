class AddChecksumToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :checksum, :string
    add_column :documents, :checksum_type, :string
  end
end
