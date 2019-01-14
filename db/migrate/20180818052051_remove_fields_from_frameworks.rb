class RemoveFieldsFromFrameworks < ActiveRecord::Migration[5.1]
  def change
    remove_reference :languages, :repository
    remove_reference :languages, :user
    add_column :languages, :image, :text
    remove_reference :frameworks, :repository
    remove_reference :frameworks, :user
    add_column :frameworks, :image, :text
  end
end
