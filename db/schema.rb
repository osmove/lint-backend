# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_01_131900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "branches", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "default"
    t.string "name"
    t.bigint "repository_id"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["repository_id"], name: "index_branches_on_repository_id"
  end

  create_table "buildpacks", force: :cascade do |t|
    t.bigint "command_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "git_address"
    t.string "name"
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.string "web_address"
    t.index ["command_id"], name: "index_buildpacks_on_command_id"
    t.index ["repository_id"], name: "index_buildpacks_on_repository_id"
    t.index ["user_id"], name: "index_buildpacks_on_user_id"
  end

  create_table "buttons", force: :cascade do |t|
    t.bigint "command_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["command_id"], name: "index_buttons_on_command_id"
    t.index ["repository_id"], name: "index_buttons_on_repository_id"
    t.index ["user_id"], name: "index_buttons_on_user_id"
  end

  create_table "changes", force: :cascade do |t|
    t.bigint "commit_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "document_id"
    t.string "operation"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["commit_id"], name: "index_changes_on_commit_id"
    t.index ["document_id"], name: "index_changes_on_document_id"
  end

  create_table "commands", force: :cascade do |t|
    t.string "command"
    t.datetime "created_at", precision: nil, null: false
    t.string "path"
    t.integer "port"
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_commands_on_repository_id"
    t.index ["user_id"], name: "index_commands_on_user_id"
  end

  create_table "commit_attempts", force: :cascade do |t|
    t.string "branch_name"
    t.bigint "commit_id"
    t.text "commit_message_feedback"
    t.integer "commit_message_score"
    t.bigint "contributor_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.bigint "device_id"
    t.boolean "has_autofix", default: false
    t.boolean "has_encryption"
    t.boolean "has_eslint", default: false
    t.boolean "has_lint", default: false
    t.boolean "has_prettier", default: false
    t.boolean "has_pylint", default: false
    t.boolean "has_rubocop", default: false
    t.string "message"
    t.boolean "passed"
    t.bigint "push_id"
    t.bigint "repository_id"
    t.string "secret_key"
    t.string "sha"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["commit_id"], name: "index_commit_attempts_on_commit_id"
    t.index ["contributor_id"], name: "index_commit_attempts_on_contributor_id"
    t.index ["device_id"], name: "index_commit_attempts_on_device_id"
    t.index ["push_id"], name: "index_commit_attempts_on_push_id"
    t.index ["repository_id"], name: "index_commit_attempts_on_repository_id"
    t.index ["user_id"], name: "index_commit_attempts_on_user_id"
  end

  create_table "commits", force: :cascade do |t|
    t.string "contributor_email"
    t.bigint "contributor_id"
    t.string "contributor_name"
    t.string "contributor_raw"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "date", precision: nil
    t.string "date_raw"
    t.boolean "has_autofix", default: false
    t.boolean "has_encryption"
    t.boolean "has_eslint", default: false
    t.boolean "has_lint", default: false
    t.boolean "has_prettier", default: false
    t.boolean "has_pylint", default: false
    t.boolean "has_rubocop", default: false
    t.string "message"
    t.bigint "push_id"
    t.bigint "repository_id"
    t.string "secret_key"
    t.string "sha"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["contributor_id"], name: "index_commits_on_contributor_id"
    t.index ["push_id"], name: "index_commits_on_push_id"
    t.index ["repository_id"], name: "index_commits_on_repository_id"
    t.index ["user_id"], name: "index_commits_on_user_id"
  end

  create_table "contributors", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "name"
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_contributors_on_repository_id"
    t.index ["user_id"], name: "index_contributors_on_user_id"
  end

  create_table "decryptions", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "cypher_name"
    t.bigint "document_id"
    t.bigint "repository_id"
    t.string "status"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["document_id"], name: "index_decryptions_on_document_id"
    t.index ["repository_id"], name: "index_decryptions_on_repository_id"
    t.index ["user_id"], name: "index_decryptions_on_user_id"
  end

  create_table "dependancies", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.bigint "repository_id"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_dependancies_on_repository_id"
    t.index ["user_id"], name: "index_dependancies_on_user_id"
  end

  create_table "deploys", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_deploys_on_repository_id"
    t.index ["user_id"], name: "index_deploys_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "brand"
    t.string "browser"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "has_gatrix_connect"
    t.boolean "has_gatrix_desktop"
    t.boolean "has_notifications"
    t.datetime "last_seen", precision: nil
    t.string "model"
    t.string "os"
    t.string "os_version"
    t.string "push_token"
    t.string "sub_model"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.string "user_agent"
    t.bigint "user_id"
    t.string "uuid"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.text "base_64_content"
    t.string "checksum"
    t.string "checksum_type"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.string "default_access_role"
    t.boolean "default_two_step_authentication_method"
    t.boolean "deleted", default: false
    t.bigint "document_id"
    t.string "extension"
    t.boolean "is_folder"
    t.string "name"
    t.string "path"
    t.text "raw_content"
    t.bigint "repository_id"
    t.boolean "requires_phone_to_be_on_same_network"
    t.boolean "requires_two_step_authentication"
    t.string "secret_key"
    t.integer "size"
    t.string "slug"
    t.string "sub_sub_type"
    t.string "sub_type"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.string "uuid"
    t.index ["document_id"], name: "index_documents_on_document_id"
    t.index ["repository_id"], name: "index_documents_on_repository_id"
  end

  create_table "encryptions", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "cypher_name"
    t.bigint "document_id"
    t.bigint "repository_id"
    t.string "status"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["document_id"], name: "index_encryptions_on_document_id"
    t.index ["repository_id"], name: "index_encryptions_on_repository_id"
    t.index ["user_id"], name: "index_encryptions_on_user_id"
  end

  create_table "frameworks", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "image"
    t.string "image_url"
    t.bigint "language_id"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "visible", default: true
    t.index ["language_id"], name: "index_frameworks_on_language_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "hosting_plans", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "memory"
    t.string "name"
    t.decimal "price_per_hour", precision: 10, scale: 2
    t.decimal "price_per_month", precision: 10, scale: 2
    t.string "slug"
    t.bigint "storage"
    t.bigint "transfer"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "vcpus"
  end

  create_table "issue_messages", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "issue_id"
    t.bigint "repository_id"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.string "username"
    t.index ["issue_id"], name: "index_issue_messages_on_issue_id"
    t.index ["repository_id"], name: "index_issue_messages_on_repository_id"
    t.index ["user_id"], name: "index_issue_messages_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "framework_id"
    t.bigint "language_id"
    t.string "origin"
    t.bigint "repository_id"
    t.string "slug"
    t.string "status"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["framework_id"], name: "index_issues_on_framework_id"
    t.index ["language_id"], name: "index_issues_on_language_id"
    t.index ["repository_id"], name: "index_issues_on_repository_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "image"
    t.string "image_url"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "visible", default: true
  end

  create_table "leads", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.text "message"
    t.string "status"
    t.string "title"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "linters", force: :cascade do |t|
    t.text "command"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.integer "organization_id"
    t.string "origin"
    t.string "origin_url"
    t.string "role"
    t.bigint "team_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.string "username"
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.text "html_body"
    t.bigint "lead_id"
    t.string "name"
    t.string "origin"
    t.string "provider"
    t.text "raw_post"
    t.boolean "read"
    t.string "status"
    t.string "subject"
    t.text "text_body"
    t.string "title"
    t.string "to_email"
    t.string "to_name"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["lead_id"], name: "index_messages_on_lead_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.integer "max_repositories"
    t.integer "max_storage"
    t.integer "max_users"
    t.string "name"
    t.decimal "price_per_month"
    t.decimal "price_per_year"
    t.string "slug"
    t.string "stripe_monthly_plan_id"
    t.string "stripe_product_id"
    t.string "stripe_subscription_id"
    t.string "stripe_yearly_plan_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "framework_id"
    t.text "image"
    t.string "image_url"
    t.boolean "is_popular", default: false
    t.bigint "language_id"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "visible", default: true
    t.index ["framework_id"], name: "index_platforms_on_framework_id"
    t.index ["language_id"], name: "index_platforms_on_language_id"
  end

  create_table "policies", force: :cascade do |t|
    t.boolean "autofix", default: false
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "name"
    t.boolean "prevent_commits_on_errors", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_policies_on_user_id"
  end

  create_table "policy_checks", force: :cascade do |t|
    t.bigint "commit_attempt_id"
    t.bigint "contributor_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "device_id"
    t.integer "error_count"
    t.integer "fixable_error_count"
    t.integer "fixable_offense_count"
    t.integer "fixable_warning_count"
    t.string "name"
    t.integer "offense_count"
    t.boolean "passed"
    t.bigint "policy_id"
    t.bigint "push_id"
    t.json "report"
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.integer "warning_count"
    t.index ["commit_attempt_id"], name: "index_policy_checks_on_commit_attempt_id"
    t.index ["contributor_id"], name: "index_policy_checks_on_contributor_id"
    t.index ["device_id"], name: "index_policy_checks_on_device_id"
    t.index ["policy_id"], name: "index_policy_checks_on_policy_id"
    t.index ["push_id"], name: "index_policy_checks_on_push_id"
    t.index ["repository_id"], name: "index_policy_checks_on_repository_id"
    t.index ["user_id"], name: "index_policy_checks_on_user_id"
  end

  create_table "policy_rule_option_options", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "policy_rule_option_id"
    t.bigint "rule_option_option_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "value"
    t.index ["policy_rule_option_id"], name: "index_policy_rule_option_options_on_policy_rule_option_id"
    t.index ["rule_option_option_id"], name: "index_policy_rule_option_options_on_rule_option_option_id"
  end

  create_table "policy_rule_options", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "policy_rule_id"
    t.bigint "rule_option_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "value"
    t.index ["policy_rule_id"], name: "index_policy_rule_options_on_policy_rule_id"
    t.index ["rule_option_id"], name: "index_policy_rule_options_on_rule_option_id"
  end

  create_table "policy_rules", force: :cascade do |t|
    t.boolean "autofix", default: false
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.boolean "fixable"
    t.bigint "linter_id"
    t.string "name"
    t.string "options"
    t.bigint "policy_id"
    t.integer "position"
    t.bigint "rule_id"
    t.string "slug"
    t.string "status"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["linter_id"], name: "index_policy_rules_on_linter_id"
    t.index ["policy_id"], name: "index_policy_rules_on_policy_id"
    t.index ["rule_id"], name: "index_policy_rules_on_rule_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "slug"], name: "index_projects_on_user_id_and_slug", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "pulls", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_pulls_on_repository_id"
    t.index ["user_id"], name: "index_pulls_on_user_id"
  end

  create_table "pushes", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_pushes_on_repository_id"
    t.index ["user_id"], name: "index_pushes_on_user_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "default_access_role"
    t.boolean "default_two_step_authentication_method"
    t.boolean "deleted", default: false
    t.string "deploy_to"
    t.string "domain_slug"
    t.bigint "framework_id"
    t.string "geo_zone"
    t.string "git_address"
    t.string "git_host"
    t.string "git_url"
    t.datetime "github_created_at", precision: nil
    t.datetime "github_updated_at", precision: nil
    t.boolean "has_autofix"
    t.boolean "has_deployment"
    t.boolean "has_downloads"
    t.boolean "has_encryption"
    t.boolean "has_wiki"
    t.bigint "hosting_plan_id"
    t.string "html_url"
    t.datetime "imported_at", precision: nil
    t.boolean "is_app"
    t.boolean "is_archived"
    t.boolean "is_encrypted"
    t.boolean "is_ignored"
    t.bigint "language_id"
    t.string "name"
    t.bigint "platform_id"
    t.bigint "policy_id"
    t.boolean "prevent_commits_on_errors"
    t.bigint "project_id"
    t.boolean "requires_phone_to_be_on_same_network"
    t.boolean "requires_two_step_authentication"
    t.string "secret_key"
    t.boolean "send_reports", default: true
    t.string "server_size"
    t.integer "size"
    t.string "slug"
    t.string "ssh_url"
    t.string "status"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.string "uuid"
    t.string "web_address"
    t.string "web_url"
    t.index ["domain_slug"], name: "index_repositories_on_domain_slug"
    t.index ["framework_id"], name: "index_repositories_on_framework_id"
    t.index ["hosting_plan_id"], name: "index_repositories_on_hosting_plan_id"
    t.index ["language_id"], name: "index_repositories_on_language_id"
    t.index ["platform_id"], name: "index_repositories_on_platform_id"
    t.index ["policy_id"], name: "index_repositories_on_policy_id"
    t.index ["project_id"], name: "index_repositories_on_project_id"
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_accesses", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "enable_admin_email_notifications", default: true
    t.boolean "enable_admin_push_notifications", default: true
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.bigint "repository_id"
    t.string "role"
    t.string "status"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_repository_accesses_on_repository_id"
    t.index ["user_id"], name: "index_repository_accesses_on_user_id"
  end

  create_table "rule_checks", force: :cascade do |t|
    t.text "ai_fix"
    t.text "ai_suggestion"
    t.integer "column"
    t.integer "column_end"
    t.bigint "contributor_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "device_id"
    t.string "file_name"
    t.string "file_path"
    t.bigint "language_id"
    t.integer "line"
    t.integer "line_end"
    t.bigint "linter_id"
    t.string "message"
    t.string "name"
    t.boolean "passed"
    t.bigint "policy_check_id"
    t.bigint "push_id"
    t.bigint "repository_id"
    t.bigint "rule_id"
    t.string "severity"
    t.integer "severity_level"
    t.text "source"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["contributor_id"], name: "index_rule_checks_on_contributor_id"
    t.index ["device_id"], name: "index_rule_checks_on_device_id"
    t.index ["language_id"], name: "index_rule_checks_on_language_id"
    t.index ["linter_id"], name: "index_rule_checks_on_linter_id"
    t.index ["policy_check_id"], name: "index_rule_checks_on_policy_check_id"
    t.index ["push_id"], name: "index_rule_checks_on_push_id"
    t.index ["repository_id"], name: "index_rule_checks_on_repository_id"
    t.index ["rule_id"], name: "index_rule_checks_on_rule_id"
    t.index ["user_id"], name: "index_rule_checks_on_user_id"
  end

  create_table "rule_option_options", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "rule_option_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "value"
    t.index ["rule_option_id"], name: "index_rule_option_options_on_rule_option_id"
  end

  create_table "rule_options", force: :cascade do |t|
    t.string "condition_value"
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "name"
    t.bigint "rule_id"
    t.string "slug"
    t.string "units"
    t.datetime "updated_at", precision: nil, null: false
    t.text "value"
    t.string "value_type"
    t.index ["rule_id"], name: "index_rule_options_on_rule_id"
  end

  create_table "rules", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.boolean "fixable", default: false
    t.bigint "framework_id"
    t.bigint "language_id"
    t.bigint "linter_id"
    t.string "name"
    t.string "options"
    t.bigint "parent_id"
    t.bigint "platform_id"
    t.bigint "rule_id"
    t.string "slug"
    t.string "status"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["framework_id"], name: "index_rules_on_framework_id"
    t.index ["language_id"], name: "index_rules_on_language_id"
    t.index ["linter_id"], name: "index_rules_on_linter_id"
    t.index ["parent_id"], name: "index_rules_on_parent_id"
    t.index ["platform_id"], name: "index_rules_on_platform_id"
    t.index ["rule_id"], name: "index_rules_on_rule_id"
  end

  create_table "servers", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "ip_address"
    t.string "name"
    t.string "os"
    t.string "ssh_host"
    t.string "ssh_password"
    t.string "ssh_path"
    t.string "ssh_user"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_servers_on_user_id"
  end

  create_table "syncs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "repository_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["repository_id"], name: "index_syncs_on_repository_id"
    t.index ["user_id"], name: "index_syncs_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.string "name"
    t.bigint "team_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["team_id"], name: "index_teams_on_team_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.string "address_2"
    t.string "authentication_token"
    t.string "avatar_url"
    t.string "city"
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.string "country"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.boolean "deleted", default: false
    t.string "email", default: "", null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.string "github_id"
    t.string "github_username"
    t.boolean "has_installed_mobile_app", default: false
    t.boolean "has_launched_mobile_app", default: false
    t.boolean "has_two_step_authentication"
    t.boolean "is_organization"
    t.string "language"
    t.string "last_name"
    t.datetime "last_sign_in_at", precision: nil
    t.inet "last_sign_in_ip"
    t.string "locale"
    t.datetime "locked_at", precision: nil
    t.datetime "mobile_app_install_date", precision: nil
    t.datetime "mobile_app_launch_date", precision: nil
    t.integer "number_of_seats"
    t.string "oauth_token"
    t.bigint "organization_id"
    t.string "organization_name"
    t.bigint "plan_id"
    t.string "provider"
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "role"
    t.integer "sign_in_count", default: 0, null: false
    t.string "slug"
    t.string "state"
    t.string "status"
    t.string "stripe_customer_id"
    t.string "stripe_product_id"
    t.string "stripe_subscription_id"
    t.string "time_zone"
    t.datetime "token_expires_at", precision: nil
    t.boolean "two_step_authentication_method"
    t.string "type"
    t.string "uid"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.string "zip_code"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["plan_id"], name: "index_users_on_plan_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "branches", "repositories"
  add_foreign_key "buildpacks", "commands"
  add_foreign_key "buildpacks", "repositories"
  add_foreign_key "buildpacks", "users"
  add_foreign_key "buttons", "commands"
  add_foreign_key "buttons", "repositories"
  add_foreign_key "buttons", "users"
  add_foreign_key "changes", "commits"
  add_foreign_key "changes", "documents"
  add_foreign_key "commands", "repositories"
  add_foreign_key "commands", "users"
  add_foreign_key "commit_attempts", "commits"
  add_foreign_key "commit_attempts", "contributors"
  add_foreign_key "commit_attempts", "devices"
  add_foreign_key "commit_attempts", "pushes"
  add_foreign_key "commit_attempts", "repositories"
  add_foreign_key "commit_attempts", "users"
  add_foreign_key "commits", "contributors"
  add_foreign_key "commits", "pushes"
  add_foreign_key "commits", "repositories"
  add_foreign_key "commits", "users"
  add_foreign_key "contributors", "repositories"
  add_foreign_key "contributors", "users"
  add_foreign_key "decryptions", "documents"
  add_foreign_key "decryptions", "repositories"
  add_foreign_key "decryptions", "users"
  add_foreign_key "dependancies", "repositories"
  add_foreign_key "dependancies", "users"
  add_foreign_key "deploys", "repositories"
  add_foreign_key "deploys", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "documents", "documents"
  add_foreign_key "documents", "repositories"
  add_foreign_key "encryptions", "documents"
  add_foreign_key "encryptions", "repositories"
  add_foreign_key "encryptions", "users"
  add_foreign_key "frameworks", "languages"
  add_foreign_key "issue_messages", "issues"
  add_foreign_key "issue_messages", "repositories"
  add_foreign_key "issue_messages", "users"
  add_foreign_key "issues", "frameworks"
  add_foreign_key "issues", "languages"
  add_foreign_key "issues", "repositories"
  add_foreign_key "issues", "users"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "leads"
  add_foreign_key "messages", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "platforms", "frameworks"
  add_foreign_key "platforms", "languages"
  add_foreign_key "policies", "users"
  add_foreign_key "policy_checks", "commit_attempts"
  add_foreign_key "policy_checks", "contributors"
  add_foreign_key "policy_checks", "devices"
  add_foreign_key "policy_checks", "policies"
  add_foreign_key "policy_checks", "pushes"
  add_foreign_key "policy_checks", "repositories"
  add_foreign_key "policy_checks", "users"
  add_foreign_key "policy_rule_option_options", "policy_rule_options"
  add_foreign_key "policy_rule_option_options", "rule_option_options"
  add_foreign_key "policy_rule_options", "policy_rules"
  add_foreign_key "policy_rule_options", "rule_options"
  add_foreign_key "policy_rules", "linters"
  add_foreign_key "policy_rules", "policies"
  add_foreign_key "policy_rules", "rules"
  add_foreign_key "projects", "users"
  add_foreign_key "pulls", "repositories"
  add_foreign_key "pulls", "users"
  add_foreign_key "pushes", "repositories"
  add_foreign_key "pushes", "users"
  add_foreign_key "repositories", "frameworks"
  add_foreign_key "repositories", "hosting_plans"
  add_foreign_key "repositories", "languages"
  add_foreign_key "repositories", "platforms"
  add_foreign_key "repositories", "policies"
  add_foreign_key "repositories", "projects"
  add_foreign_key "repositories", "users"
  add_foreign_key "repository_accesses", "repositories"
  add_foreign_key "repository_accesses", "users"
  add_foreign_key "rule_checks", "contributors"
  add_foreign_key "rule_checks", "devices"
  add_foreign_key "rule_checks", "languages"
  add_foreign_key "rule_checks", "linters"
  add_foreign_key "rule_checks", "policy_checks"
  add_foreign_key "rule_checks", "pushes"
  add_foreign_key "rule_checks", "repositories"
  add_foreign_key "rule_checks", "rules"
  add_foreign_key "rule_checks", "users"
  add_foreign_key "rule_option_options", "rule_options"
  add_foreign_key "rule_options", "rules"
  add_foreign_key "rules", "frameworks"
  add_foreign_key "rules", "languages"
  add_foreign_key "rules", "linters"
  add_foreign_key "rules", "platforms"
  add_foreign_key "servers", "users"
  add_foreign_key "syncs", "repositories"
  add_foreign_key "syncs", "users"
  add_foreign_key "teams", "teams"
  add_foreign_key "teams", "users"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "plans"
end
