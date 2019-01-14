class AddLanguageToFrameworks < ActiveRecord::Migration[5.1]
  def change
    add_reference :frameworks, :language, foreign_key: true
  end
end
