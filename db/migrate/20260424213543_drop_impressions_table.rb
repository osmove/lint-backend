class DropImpressionsTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :impressions, if_exists: true
    remove_column :repositories, :counter_cache, if_exists: true
    remove_column :users, :counter_cache, if_exists: true
  end

  def down
    # The `impressionist` gem populated these structures since 2018 but
    # nothing in the codebase ever read the data. The migration is
    # reversible only in shape: rolling back recreates the table and the
    # two counter_cache columns, but the historical impression rows are
    # gone.
    create_table :impressions do |t|
      t.string :impressionable_type
      t.integer :impressionable_id
      t.integer :user_id
      t.string :controller_name
      t.string :action_name
      t.string :view_name
      t.string :request_hash
      t.string :ip_address
      t.string :session_hash
      t.text :message
      t.text :referrer
      t.text :params
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_index :impressions, %i[controller_name action_name ip_address], name: "controlleraction_ip_index"
    add_index :impressions, %i[controller_name action_name request_hash], name: "controlleraction_request_index"
    add_index :impressions, %i[controller_name action_name session_hash], name: "controlleraction_session_index"
    add_index :impressions, %i[impressionable_type impressionable_id ip_address], name: "poly_ip_index"
    add_index :impressions, %i[impressionable_type impressionable_id params], name: "poly_params_request_index"
    add_index :impressions, %i[impressionable_type impressionable_id request_hash], name: "poly_request_index"
    add_index :impressions, %i[impressionable_type impressionable_id session_hash], name: "poly_session_index"
    add_index :impressions, %i[impressionable_type message impressionable_id], name: "impressionable_type_message_index"
    add_index :impressions, :user_id, name: "index_impressions_on_user_id"

    add_column :repositories, :counter_cache, :integer
    add_column :users, :counter_cache, :integer
  end
end
