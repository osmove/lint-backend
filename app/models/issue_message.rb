class IssueMessage < ApplicationRecord
  belongs_to :issue
  belongs_to :repository
  belongs_to :user

  is_impressionable

end
