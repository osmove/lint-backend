class AddPolicyToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_reference :repositories, :policy, foreign_key: true
  end
end
