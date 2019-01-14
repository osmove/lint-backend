class AddReportToPolicyCheck < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_checks, :report, :json
  end
end
