class Issue < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  belongs_to :language, optional: true
  belongs_to :framework, optional: true
end
