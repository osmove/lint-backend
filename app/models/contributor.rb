class Contributor < ApplicationRecord
  belongs_to :repository
  belongs_to :user, optional: true
  has_many :commits
  has_many :commit_attempts
  has_many :policy_checks
  has_many :rules_checks


  def name_or_username
    @name_or_username = self.name
    @name_or_username
  end

  before_save :check_if_user_is_contributor

  def check_if_user_is_contributor
    if self.user_id.blank?
      @user = User.where(email: self.email).first
      if @user.present?
        self.user = @user
      end
    end
  end
end
