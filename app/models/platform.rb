class Platform < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :framework, optional: true

  def to_s
    self.name
  end
  
end
