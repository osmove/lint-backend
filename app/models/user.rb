class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: %i[github],
                                                                 authentication_keys: [:login]

  attr_accessor :current_password

  # validates :username, presence: :true, unless: -> { from_omniauth? }, if: :check_if_user
  # validates :email, presence: :true, unless: -> { from_omniauth? }, if: :check_if_user
  # validates :password, presence: :true, :on => :create, unless: -> { from_omniauth? }, if: :check_if_user

  validates :organization_name, presence: :true, if: :check_if_organization

  # validates :username, presence: :true, uniqueness: { case_sensitive: false }, unless: -> { from_omniauth? }, unless: :check_if_organization
  validates :username, presence: :true, uniqueness: { case_sensitive: false }, unless: -> { from_omniauth? }
  validates :email, presence: :true, uniqueness: { case_sensitive: false }, unless: -> { from_omniauth? }
  validates :password, presence: :true, on: :create, unless: -> { from_omniauth? }

  # validates :password_confirmation, presence: :true

  has_many :repositories, dependent: :destroy
  # has_many :repositories
  has_many :messages

  has_many :repository_accesses
  has_many :repositories_with_access, through: :repository_accesses, source: :repository

  # has_many :memberships
  # has_many :memberships

  has_many :memberships_as_organization, foreign_key: :organization_id, class_name: 'Membership'
  # has_many :memberships_as_user, foreign_key: :user_id, class_name: 'Membership'
  has_many :memberships, class_name: 'Membership'

  has_many :members, through: :memberships_as_organization, source: :user

  has_many :organizations, through: :memberships

  # has_many :teams
  has_many :teams_created, class_name: 'Team'

  has_many :teams, through: :memberships

  has_many :commit_attempts
  has_many :policies

  has_many :policy_checks
  has_many :rules_checks

  has_many :commands
  has_many :buildpacks
  has_many :commits
  has_many :devices

  belongs_to :plan, optional: true

  self.inheritance_column = :_type_disabled

  def to_s
    username
  end

  def check_if_user
    return true if [false, nil].include?(is_organization)

    false
  end

  def check_if_organization
    return true if is_organization.present? && is_organization == true

    false
  end

  def greet
    current_time = Time.now.to_i

    midnight = Time.now.beginning_of_day.to_i
    noon = Time.now.middle_of_day.to_i
    five_pm = Time.now.change(hour: 17).to_i
    eight_pm = Time.now.change(hour: 20).to_i

    username = self.username || 'guest'

    if midnight.upto(noon).include?(current_time)
      "Good morning, #{username}"
    elsif noon.upto(five_pm).include?(current_time)
      "Good afternoon, #{username}"
    elsif five_pm.upto(eight_pm).include?(current_time)
      "Good evening, #{username}"
    elsif eight_pm.upto(midnight + 1.day).include?(current_time)
      "Good night, #{username}"
    end
  end

  def send_push_notification(title, message)
    return nil unless title.present? || message.present?

    # Send push notification
    push_messages = []
    devices.each do |device|
      next unless device.has_notifications? && device.push_token.present?

      push_message = {
        to: device.push_token,
        sound: 'default',
        title: title,
        body: message
      }
      push_messages << push_message
    end

    if push_messages.length > 0
      expo_push_client = Exponent::Push::Client.new
      expo_push_client.publish(push_messages)
    end

    push_messages.length
  end

  # Username Autogeneration
  # after_initialize :create_login, :if => :new_record?
  #
  # def create_login
  #   if self.username.blank?
  #     email = self.email.split(/@/)
  #     login_taken = User.where(:username => email[0]).first
  #     unless login_taken
  #       self.username = email[0]
  #     else
  #       self.username = self.email
  #     end
  #   end
  # end

  attr_writer :login

  def login
    @login || username || email
  end

  def admin?
    role == 'admin'
  end

  # Generate authentication_token
  before_save :ensure_authentication_token
  before_create :set_defaults
  def set_defaults
    self.number_of_seats ||= 1
    self.plan ||= Plan.order(:id).first
  end

  # before_create :add_creator_to_members
  # def add_creator_to_members
  #   if self.is_organization == true
  #     membership = Membership.create({user: current_user, role: 'admin'})
  #     self.memberships_as_organization.push(membership)
  #   end
  # end

  # before_create :add_free_plan
  # def add_free_plan
  #   unless self.plan.present?
  #     free_plan = Plan.findBySlug("free").first rescue nil
  #     if free_plan.present?
  #       self.plan = free_plan
  #     end
  #   end
  # end

  # after_create :send_welcome_email
  # def send_welcome_email
  #   unless self.is_organization == true
  #     UserMailer.welcome_email(self).deliver_now
  #   end
  # end

  def name
    parts = []
    parts << first_name if first_name.present?
    parts << last_name if last_name.present?
    @name = parts.join(' ')
  end

  def name_or_username
    @name_or_username = name
    @name_or_username = username if @name_or_username == ''
    @name_or_username
  end

  validate :validate_username
  def validate_username
    return unless User.where(email: username).exists?

    errors.add(:username, :invalid)
  end

  def to_param
    username.downcase
  end

  extend FriendlyId

  # has_many :repositories
  friendly_id :username, use: :slugged

  def normalize_friendly_id(value)
    value.to_s.parameterize(separator: '-', preserve_case: false)
  end

  def ensure_authentication_token
    return if authentication_token.present?

    self.authentication_token = generate_authentication_token
  end

  def self.from_omniauth(auth)
    existing_user = where(username: auth.info.nickname).first
    if existing_user
      existing_user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email || "#{auth.uid}@github.com"
        user.password = Devise.friendly_token[0, 20]
        user.username = auth.info.nickname
        user.github_id = auth.uid
        user.github_username = auth.info.nickname
        # user.name = auth.info.name   # assuming the user model has a name
        # user.image = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end
  end

protected

  # Remove confirmation required
  def confirmation_required?
    if from_omniauth?
      false
    else
      true
    end
  end

private

  def from_omniauth?
    provider && uid
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token(50)
      break token unless User.where(authentication_token: token).first
    end
  end

  # Default one
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions.to_h).where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  #   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
  #     conditions[:email].downcase! if conditions[:email]
  #     where(conditions.to_h).first
  #   end
  # end

  # To be able to request new password with username instead of email
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['username = :value OR lower(email) = lower(:value)', { value: login }]).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end
