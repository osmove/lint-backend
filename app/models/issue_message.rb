class IssueMessage < ApplicationRecord
  belongs_to :issue
  belongs_to :repository
  belongs_to :user
end
