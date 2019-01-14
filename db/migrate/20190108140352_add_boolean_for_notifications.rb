class AddBooleanForNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :enable_email_notifications, :boolean, default: true
    add_column :users, :enable_push_notifications, :boolean, default: true

    add_column :teams, :enable_email_notifications, :boolean, default: true
    add_column :teams, :enable_push_notifications, :boolean, default: true

    add_column :organizations, :enable_email_notifications, :boolean, default: true
    add_column :organizations, :enable_push_notifications, :boolean, default: true

    add_column :memberships, :enable_email_notifications, :boolean, default: true
    add_column :memberships, :enable_push_notifications, :boolean, default: true

    add_column :repository_accesses, :enable_email_notifications, :boolean, default: true
    add_column :repository_accesses, :enable_push_notifications, :boolean, default: true

    add_column :repository_accesses, :enable_admin_email_notifications, :boolean, default: true
    add_column :repository_accesses, :enable_admin_push_notifications, :boolean, default: true
  end
end
