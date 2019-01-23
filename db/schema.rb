# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190123185610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.boolean "default"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_branches_on_repository_id"
  end

  create_table "buildpacks", force: :cascade do |t|
    t.string "name"
    t.string "web_address"
    t.string "git_address"
    t.bigint "command_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_id"], name: "index_buildpacks_on_command_id"
    t.index ["repository_id"], name: "index_buildpacks_on_repository_id"
    t.index ["user_id"], name: "index_buildpacks_on_user_id"
  end

  create_table "buttons", force: :cascade do |t|
    t.bigint "command_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_id"], name: "index_buttons_on_command_id"
    t.index ["repository_id"], name: "index_buttons_on_repository_id"
    t.index ["user_id"], name: "index_buttons_on_user_id"
  end

  create_table "changes", force: :cascade do |t|
    t.string "operation"
    t.bigint "document_id"
    t.bigint "commit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commit_id"], name: "index_changes_on_commit_id"
    t.index ["document_id"], name: "index_changes_on_document_id"
  end

  create_table "commands", force: :cascade do |t|
    t.string "command"
    t.string "path"
    t.integer "port"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_commands_on_repository_id"
    t.index ["user_id"], name: "index_commands_on_user_id"
  end

  create_table "commit_attempts", force: :cascade do |t|
    t.string "message"
    t.string "description"
    t.bigint "commit_id"
    t.bigint "user_id"
    t.bigint "contributor_id"
    t.bigint "push_id"
    t.bigint "device_id"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sha"
    t.string "branch_name"
    t.boolean "has_encryption"
    t.string "secret_key"
    t.boolean "has_autofix", default: false
    t.boolean "has_lint", default: false
    t.boolean "has_prettier", default: false
    t.boolean "has_eslint", default: false
    t.boolean "has_rubocop", default: false
    t.boolean "has_pylint", default: false
    t.boolean "passed"
    t.index ["commit_id"], name: "index_commit_attempts_on_commit_id"
    t.index ["contributor_id"], name: "index_commit_attempts_on_contributor_id"
    t.index ["device_id"], name: "index_commit_attempts_on_device_id"
    t.index ["push_id"], name: "index_commit_attempts_on_push_id"
    t.index ["repository_id"], name: "index_commit_attempts_on_repository_id"
    t.index ["user_id"], name: "index_commit_attempts_on_user_id"
  end

  create_table "commits", force: :cascade do |t|
    t.string "message"
    t.datetime "date"
    t.string "date_raw"
    t.string "contributor_raw"
    t.string "contributor_name"
    t.string "contributor_email"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "push_id"
    t.string "sha"
    t.bigint "contributor_id"
    t.boolean "has_encryption"
    t.string "secret_key"
    t.boolean "has_autofix", default: false
    t.boolean "has_lint", default: false
    t.boolean "has_prettier", default: false
    t.boolean "has_eslint", default: false
    t.boolean "has_rubocop", default: false
    t.boolean "has_pylint", default: false
    t.index ["contributor_id"], name: "index_commits_on_contributor_id"
    t.index ["push_id"], name: "index_commits_on_push_id"
    t.index ["repository_id"], name: "index_commits_on_repository_id"
    t.index ["user_id"], name: "index_commits_on_user_id"
  end

  create_table "contributors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_contributors_on_repository_id"
    t.index ["user_id"], name: "index_contributors_on_user_id"
  end

  create_table "decryptions", force: :cascade do |t|
    t.string "status"
    t.string "cypher_name"
    t.bigint "document_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_decryptions_on_document_id"
    t.index ["repository_id"], name: "index_decryptions_on_repository_id"
    t.index ["user_id"], name: "index_decryptions_on_user_id"
  end

  create_table "dependancies", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_dependancies_on_repository_id"
    t.index ["user_id"], name: "index_dependancies_on_user_id"
  end

  create_table "deploys", force: :cascade do |t|
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_deploys_on_repository_id"
    t.index ["user_id"], name: "index_deploys_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type"
    t.string "brand"
    t.string "model"
    t.string "sub_model"
    t.string "uuid"
    t.string "os"
    t.string "os_version"
    t.boolean "has_notifications"
    t.boolean "has_gatrix_desktop"
    t.boolean "has_gatrix_connect"
    t.datetime "last_seen"
    t.string "browser"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "push_token"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.boolean "is_folder"
    t.integer "size"
    t.string "extension"
    t.text "content"
    t.bigint "repository_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "uuid"
    t.string "secret_key"
    t.boolean "requires_two_step_authentication"
    t.boolean "default_two_step_authentication_method"
    t.boolean "requires_phone_to_be_on_same_network"
    t.string "default_access_role"
    t.string "checksum"
    t.string "checksum_type"
    t.string "type"
    t.boolean "deleted", default: false
    t.string "sub_type"
    t.string "sub_sub_type"
    t.text "raw_content"
    t.text "base_64_content"
    t.index ["document_id"], name: "index_documents_on_document_id"
    t.index ["repository_id"], name: "index_documents_on_repository_id"
  end

  create_table "encryptions", force: :cascade do |t|
    t.string "status"
    t.string "cypher_name"
    t.bigint "document_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_encryptions_on_document_id"
    t.index ["repository_id"], name: "index_encryptions_on_repository_id"
    t.index ["user_id"], name: "index_encryptions_on_user_id"
  end

  create_table "frameworks", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image"
    t.bigint "language_id"
    t.string "image_url"
    t.boolean "visible", default: true
    t.index ["language_id"], name: "index_frameworks_on_language_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "hosting_plans", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "vcpus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_per_month", precision: 10, scale: 2
    t.decimal "price_per_hour", precision: 10, scale: 2
    t.bigint "memory"
    t.bigint "storage"
    t.bigint "transfer"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "issue_messages", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "body"
    t.string "username"
    t.bigint "issue_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_messages_on_issue_id"
    t.index ["repository_id"], name: "index_issue_messages_on_repository_id"
    t.index ["user_id"], name: "index_issue_messages_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.string "origin"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.bigint "language_id"
    t.bigint "framework_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.string "status"
    t.index ["framework_id"], name: "index_issues_on_framework_id"
    t.index ["language_id"], name: "index_issues_on_language_id"
    t.index ["repository_id"], name: "index_issues_on_repository_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image"
    t.string "image_url"
    t.boolean "visible", default: true
  end

  create_table "leads", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "title"
    t.text "message"
    t.string "type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "command"
  end

  create_table "memberships", force: :cascade do |t|
    t.string "username"
    t.string "origin"
    t.string "origin_url"
    t.string "avatar_url"
    t.string "role"
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "title"
    t.text "message"
    t.string "type"
    t.string "status"
    t.boolean "read"
    t.bigint "user_id"
    t.bigint "lead_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "to_name"
    t.string "to_email"
    t.string "subject"
    t.string "origin"
    t.string "provider"
    t.text "raw_post"
    t.index ["lead_id"], name: "index_messages_on_lead_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.decimal "price_per_month"
    t.decimal "price_per_year"
    t.integer "max_users"
    t.integer "max_repositories"
    t.integer "max_storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_subscription_id"
    t.string "stripe_product_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.bigint "language_id"
    t.bigint "framework_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "image"
    t.string "image_url"
    t.boolean "visible", default: true
    t.boolean "is_popular", default: false
    t.index ["framework_id"], name: "index_platforms_on_framework_id"
    t.index ["language_id"], name: "index_platforms_on_language_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "autofix", default: false
    t.boolean "prevent_commits_on_errors", default: true
    t.index ["user_id"], name: "index_policies_on_user_id"
  end

  create_table "policy_checks", force: :cascade do |t|
    t.string "name"
    t.boolean "passed"
    t.bigint "commit_attempt_id"
    t.bigint "policy_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.bigint "contributor_id"
    t.bigint "push_id"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "error_count"
    t.integer "warning_count"
    t.integer "offense_count"
    t.integer "fixable_warning_count"
    t.integer "fixable_error_count"
    t.integer "fixable_offense_count"
    t.json "report"
    t.index ["commit_attempt_id"], name: "index_policy_checks_on_commit_attempt_id"
    t.index ["contributor_id"], name: "index_policy_checks_on_contributor_id"
    t.index ["device_id"], name: "index_policy_checks_on_device_id"
    t.index ["policy_id"], name: "index_policy_checks_on_policy_id"
    t.index ["push_id"], name: "index_policy_checks_on_push_id"
    t.index ["repository_id"], name: "index_policy_checks_on_repository_id"
    t.index ["user_id"], name: "index_policy_checks_on_user_id"
  end

  create_table "policy_rule_option_options", force: :cascade do |t|
    t.bigint "policy_rule_option_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rule_option_option_id"
    t.index ["policy_rule_option_id"], name: "index_policy_rule_option_options_on_policy_rule_option_id"
    t.index ["rule_option_option_id"], name: "index_policy_rule_option_options_on_rule_option_option_id"
  end

  create_table "policy_rule_options", force: :cascade do |t|
    t.bigint "policy_rule_id"
    t.bigint "rule_option_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["policy_rule_id"], name: "index_policy_rule_options_on_policy_rule_id"
    t.index ["rule_option_id"], name: "index_policy_rule_options_on_rule_option_id"
  end

  create_table "policy_rules", force: :cascade do |t|
    t.bigint "rule_id"
    t.bigint "policy_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.boolean "autofix", default: false
    t.string "options"
    t.string "name"
    t.string "slug"
    t.text "description"
    t.string "type"
    t.boolean "fixable"
    t.bigint "linter_id"
    t.index ["linter_id"], name: "index_policy_rules_on_linter_id"
    t.index ["policy_id"], name: "index_policy_rules_on_policy_id"
    t.index ["rule_id"], name: "index_policy_rules_on_rule_id"
  end

  create_table "pulls", force: :cascade do |t|
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_pulls_on_repository_id"
    t.index ["user_id"], name: "index_pulls_on_user_id"
  end

  create_table "pushes", force: :cascade do |t|
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_pushes_on_repository_id"
    t.index ["user_id"], name: "index_pushes_on_user_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "git_address"
    t.string "web_address"
    t.boolean "has_encryption"
    t.boolean "is_encrypted"
    t.boolean "is_app"
    t.boolean "has_deployment"
    t.string "uuid"
    t.string "secret_key"
    t.boolean "requires_two_step_authentication"
    t.boolean "default_two_step_authentication_method"
    t.boolean "requires_phone_to_be_on_same_network"
    t.string "default_access_role"
    t.string "type"
    t.boolean "deleted", default: false
    t.integer "counter_cache"
    t.bigint "language_id"
    t.bigint "framework_id"
    t.bigint "platform_id"
    t.string "deploy_to"
    t.string "server_size"
    t.string "domain_slug"
    t.string "geo_zone"
    t.bigint "hosting_plan_id"
    t.string "web_url"
    t.string "html_url"
    t.string "git_url"
    t.string "ssh_url"
    t.datetime "github_updated_at"
    t.datetime "github_created_at"
    t.datetime "imported_at"
    t.string "git_host"
    t.boolean "is_archived"
    t.integer "size"
    t.boolean "has_downloads"
    t.boolean "has_wiki"
    t.boolean "is_ignored"
    t.bigint "policy_id"
    t.boolean "has_autofix"
    t.boolean "prevent_commits_on_errors"
    t.boolean "send_reports", default: true
    t.index ["domain_slug"], name: "index_repositories_on_domain_slug"
    t.index ["framework_id"], name: "index_repositories_on_framework_id"
    t.index ["hosting_plan_id"], name: "index_repositories_on_hosting_plan_id"
    t.index ["language_id"], name: "index_repositories_on_language_id"
    t.index ["platform_id"], name: "index_repositories_on_platform_id"
    t.index ["policy_id"], name: "index_repositories_on_policy_id"
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_accesses", force: :cascade do |t|
    t.string "role"
    t.string "status"
    t.bigint "user_id"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.boolean "enable_admin_email_notifications", default: true
    t.boolean "enable_admin_push_notifications", default: true
    t.index ["repository_id"], name: "index_repository_accesses_on_repository_id"
    t.index ["user_id"], name: "index_repository_accesses_on_user_id"
  end

  create_table "rule_checks", force: :cascade do |t|
    t.string "name"
    t.boolean "passed"
    t.bigint "language_id"
    t.bigint "rule_id"
    t.bigint "policy_check_id"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.bigint "contributor_id"
    t.bigint "push_id"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name"
    t.string "file_path"
    t.bigint "linter_id"
    t.string "severity"
    t.integer "severity_level"
    t.string "message"
    t.integer "line"
    t.integer "column"
    t.integer "line_end"
    t.integer "column_end"
    t.text "source"
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
    t.bigint "rule_option_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rule_option_id"], name: "index_rule_option_options_on_rule_option_id"
  end

  create_table "rule_options", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "value"
    t.string "value_type"
    t.string "units"
    t.string "condition_value"
    t.bigint "rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["rule_id"], name: "index_rule_options_on_rule_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.text "description"
    t.string "status"
    t.bigint "language_id"
    t.bigint "framework_id"
    t.bigint "platform_id"
    t.bigint "rule_id"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "linter_id"
    t.boolean "fixable", default: false
    t.string "options"
    t.string "slug"
    t.index ["framework_id"], name: "index_rules_on_framework_id"
    t.index ["language_id"], name: "index_rules_on_language_id"
    t.index ["linter_id"], name: "index_rules_on_linter_id"
    t.index ["parent_id"], name: "index_rules_on_parent_id"
    t.index ["platform_id"], name: "index_rules_on_platform_id"
    t.index ["rule_id"], name: "index_rules_on_rule_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "ip_address"
    t.string "os"
    t.string "ssh_host"
    t.string "ssh_user"
    t.string "ssh_password"
    t.string "ssh_path"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_servers_on_user_id"
  end

  create_table "syncs", force: :cascade do |t|
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_syncs_on_repository_id"
    t.index ["user_id"], name: "index_syncs_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "avatar_url"
    t.bigint "team_id"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
    t.index ["team_id"], name: "index_teams_on_team_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "slug"
    t.string "time_zone"
    t.string "locale"
    t.string "language"
    t.string "authentication_token"
    t.boolean "has_two_step_authentication"
    t.boolean "two_step_authentication_method"
    t.string "status"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.bigint "plan_id"
    t.string "role"
    t.string "address"
    t.string "address_2"
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.string "country"
    t.boolean "is_organization"
    t.string "organization_name"
    t.bigint "organization_id"
    t.string "first_name"
    t.string "last_name"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.string "stripe_product_id"
    t.string "type"
    t.boolean "has_installed_mobile_app", default: false
    t.datetime "mobile_app_install_date"
    t.boolean "has_launched_mobile_app", default: false
    t.datetime "mobile_app_launch_date"
    t.boolean "deleted", default: false
    t.integer "counter_cache"
    t.string "uid"
    t.string "provider"
    t.string "oauth_token"
    t.string "github_username"
    t.string "github_id"
    t.string "avatar_url"
    t.datetime "token_expires_at"
    t.boolean "enable_email_notifications", default: true
    t.boolean "enable_push_notifications", default: true
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
  add_foreign_key "pulls", "repositories"
  add_foreign_key "pulls", "users"
  add_foreign_key "pushes", "repositories"
  add_foreign_key "pushes", "users"
  add_foreign_key "repositories", "frameworks"
  add_foreign_key "repositories", "hosting_plans"
  add_foreign_key "repositories", "languages"
  add_foreign_key "repositories", "platforms"
  add_foreign_key "repositories", "policies"
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
