class AddTwoStepAuthenticationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_two_step_authentication, :boolean
    add_column :users, :two_step_authentication_method, :boolean
    add_column :repositories, :requires_two_step_authentication, :boolean
    add_column :repositories, :default_two_step_authentication_method, :boolean
    add_column :repositories, :requires_phone_to_be_on_same_network, :boolean
    add_column :repositories, :default_access_role, :string
    add_column :documents, :requires_two_step_authentication, :boolean
    add_column :documents, :default_two_step_authentication_method, :boolean
    add_column :documents, :requires_phone_to_be_on_same_network, :boolean
    add_column :documents, :default_access_role, :string
  end
end
