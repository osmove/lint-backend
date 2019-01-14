class AddPlatformToRepositoriesAgain < ActiveRecord::Migration[5.1]
  def change
    add_reference :repositories, :platform, foreign_key: true
  end
end
