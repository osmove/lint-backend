class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lead, optional: true
  
  self.inheritance_column = :_type_disabled

end
