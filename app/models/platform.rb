class Platform < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :framework, optional: true

  def to_s
    name
  end
end
