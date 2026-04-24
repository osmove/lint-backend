class Contributor < ApplicationRecord
  belongs_to :repository
  belongs_to :user, optional: true
  has_many :commits
  has_many :commit_attempts
  has_many :policy_checks
  has_many :rules_checks

  def name_or_username
    @name_or_username = name
    @name_or_username
  end

  before_save :check_if_user_is_contributor

  def check_if_user_is_contributor
    return if user_id.present?

    @user = User.where(email: email).first
    return if @user.blank?

    self.user = @user
  end
end
