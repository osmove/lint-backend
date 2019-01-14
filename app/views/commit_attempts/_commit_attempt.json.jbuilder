# json.extract! commit_attempt, :id, :message, :description, :commit_id, :user_id, :contributor_id, :push_id, :device_id, :created_at, :updated_at
# # json.(commit_attempt.repository, :id, :name, :slug, :status, :user_id, :created_at, :updated_at, :uuid, :has_encryption, :is_encrypted, :has_deployment, :policy, :documents)
# json.repository do
#   json.name commit_attempt.repository.name
#   json.id commit_attempt.repository.id
#   json.status commit_attempt.repository.status
#   json.uuid commit_attempt.repository.uuid
#   json.url user_repository_url(commit_attempt.repository.user, commit_attempt.repository)
#   json.policy do
#
#     json.info policy if policy.present?
#     if policy.policy_rules.count > 0
#       json.policy_rules policy.policy_rules do |policy_rule|
#         json.rule do
#           json.name policy_rule.rule.name if policy_rule.rule.present?
#           json.status policy_rule.status if policy_rule.present?
#           json.options policy_rule.options if policy_rule.options.present?
#           json.rule_options policy_rule.rule.rule_options if policy_rule.options.present?
#
#           json.policy_rule_options policy_rule.policy_rule_options if policy_rule.options.present?
#
#           json.fix policy_rule.autofix if policy_rule.present?
#
#           json.linter do
#             json.linter policy_rule.rule.linter
#           end
#         end
#       end
#     end
#
#   end
# end
#
# json.url commit_attempt_url(commit_attempt, format: :json)
#lslslsl

# json.cache! ['v1', policy], expires_in: 5.minutes do
# json.cache! ['v1', policy] do

  json.content commit_attempt
  json.url commit_attempt_url(commit_attempt, format: :json)
  json.repository commit_attempt.repository
  # json.repository do
  #   json.content commit_attempt.repository
  # end

  if policy.present?
    json.policy do
      json.content policy
      if policy.policy_rules.count > 0
        json.policy_rules policy.policy_rules do |policy_rule|
          json.status policy_rule.status
          json.rule do
            json.content policy_rule.rule
            json.linter policy_rule.rule.linter
              # json.selected_options option.policy_rule_option_options do |selected_option|
              #  json.content selected_option
              #  if selected_option.rule_option_option.present?
              #    json.value option.value
              #  end
              # end
            # end
          end
          json.options policy_rule.policy_rule_options do |option|
            json.selected option
            json.rule_option option.rule_option
            json.rule_option_options option.rule_option_options
          end
        end
      end
    end
  end

# end
