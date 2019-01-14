class AddTypeToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string
    add_column :repositories, :type, :string
    add_column :documents, :type, :string

    add_column :users, :has_installed_mobile_app, :boolean, default: false
    add_column :users, :mobile_app_install_date, :datetime
    add_column :users, :has_launched_mobile_app, :boolean, default: false
    add_column :users, :mobile_app_launch_date, :datetime

    add_column :users, :deleted, :boolean, default: false
    add_column :repositories, :deleted, :boolean, default: false
    add_column :documents, :deleted, :boolean, default: false


  end
end
