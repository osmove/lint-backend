class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lead, optional: true

  self.inheritance_column = :_type_disabled

  after_create :send_created_email
  def send_created_email
    Rails.logger.info "%%%%%%"
    Rails.logger.info "FROM"
    Rails.logger.info self.email
    Rails.logger.info "TO"
    Rails.logger.info self.to_email
    # if self.to_email.present?
      # TODO: Add email back
      # MessageMailer.message_created_email(self).deliver_now
    # end
  end

end
