json.extract! repository, :id, :name, :slug, :status, :user_id, :created_at, :updated_at, :git_url,
:ssh_url, :uuid, :git_address, :has_encryption, :is_encrypted, :has_deployment, :secret_key

json.policy do
  if repository.policy.present? && repository.policy.policy_rules.count > 0
    json.policy_rules repository.policy.policy_rules do |policy_rule|
      if policy_rule.rule.present?
        json.rules  do
          json.name policy_rule.rule.name
          json.status policy_rule.status
          json.linter do
            json.linter policy_rule.rule.linter
          end
        end
      end
    end
  end
end
json.url user_repository_url(repository.user, repository)
