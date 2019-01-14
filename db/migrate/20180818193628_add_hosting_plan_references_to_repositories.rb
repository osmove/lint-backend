class AddHostingPlanReferencesToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_reference :repositories, :hosting_plan, foreign_key: true
  end
end
