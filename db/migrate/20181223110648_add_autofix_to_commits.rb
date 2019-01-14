class AddAutofixToCommits < ActiveRecord::Migration[5.1]
  def change

    add_column :commits, :has_autofix, :boolean, default: false
    add_column :commit_attempts, :has_autofix, :boolean, default: false

    add_column :commits, :has_lint, :boolean, default: false
    add_column :commit_attempts, :has_lint, :boolean, default: false

    add_column :commits, :has_prettier, :boolean, default: false
    add_column :commit_attempts, :has_prettier, :boolean, default: false

    add_column :commits, :has_eslint, :boolean, default: false
    add_column :commit_attempts, :has_eslint, :boolean, default: false

    add_column :commits, :has_rubocop, :boolean, default: false
    add_column :commit_attempts, :has_rubocop, :boolean, default: false

    add_column :commits, :has_pylint, :boolean, default: false
    add_column :commit_attempts, :has_pylint, :boolean, default: false

  end
end
