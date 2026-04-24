class Repository < ApplicationRecord
  LINT_CLOUD_DEPLOY_TARGET = 'lint_cloud'.freeze
  LINT_GIT_HOST = 'lint'.freeze

  require 'net/ssh'

  include ActionView::Helpers::DateHelper

  belongs_to :user

  belongs_to :policy, optional: true
  belongs_to :platform, optional: true
  belongs_to :hosting_plan, optional: true

  has_many :buildpacks, dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :commands, dependent: :destroy
  # has_many :changes, :dependent => :destroy, :as => :changed_files
  has_many :buttons, dependent: :destroy
  has_many :pulls, dependent: :destroy
  has_many :pushs, dependent: :destroy
  has_many :syncs, dependent: :destroy
  has_many :deploys, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :encryptions, dependent: :destroy
  has_many :decryptions, dependent: :destroy
  has_many :repository_accesses, dependent: :destroy
  has_many :commit_attempts, dependent: :destroy

  has_many :policy_checks, dependent: :destroy

  # has_many :users_with_access, :through => :repository_accesses
  has_many :users_with_access, through: :repository_accesses, source: :user
  # has_many :repositories, :through => :repository_accesses

  extend FriendlyId

  friendly_id :name, use: :scoped, scope: :user

  # validates :domain_slug, presence: true, uniqueness: { case_sensitive: false }, if: -> { deploy_to == 'lint_cloud' && domain_slug.blank? }

  validates :domain_slug, presence: true, if: -> { deploy_to == LINT_CLOUD_DEPLOY_TARGET }
  # validates :domain_slug, uniqueness: { case_sensitive: false }, if: -> { deploy_to == 'lint_cloud' && domain_slug.present? }
  validates :domain_slug, uniqueness: { case_sensitive: false }, if: lambda {
    deploy_to == LINT_CLOUD_DEPLOY_TARGET && domain_slug.present?
  }

  # TODO: validates_uniqueness_of :repository_id, :scope => :user_id

  # validates :domain_slug, uniqueness: { case_sensitive: false }, if: :some_complex_condition
  # def some_complex_condition
  #   if condition
  #     return true
  #   else
  #     return false
  #   end
  # end

  validates :uuid, presence: true, uniqueness: { case_sensitive: false }

  # validates :name, presence: true, uniqueness: { case_sensitive: false }
  # validates :slug, presence: true, uniqueness: { case_sensitive: false }
  # validates :platform, presence: true
  validates :name, presence: true
  validates :slug, presence: true
  validates :status, presence: true

  # validates :deploy_to, presence: true

  self.inheritance_column = :_type_disabled

  def to_s
    name
  end

  def smart_created_at
    if platform.present?
      if git_host == 'github'
        "#{platform} app created #{time_ago_in_words(github_created_at)} ago."
      else
        "#{platform} app created #{time_ago_in_words(created_at)} ago."
      end
    elsif git_host == 'github'
      "Created #{time_ago_in_words(github_created_at)} ago."
    else
      "Created #{time_ago_in_words(created_at)} ago."
    end
  end

  # after_create :send_created_email
  # def send_created_email
  #   RepositoryMailer.repository_created_email(self).deliver_now
  # end

  def self.public
    where(status: 'Public')
  end

  def self.private
    where(status: 'Private')
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  # def normalize_friendly_id(value)
  #   value.to_s.parameterize(separator: "-", preserve_case: false)
  # end

  def git_address
    @git_address = if git_host == 'github'
                     git_url
                   else
                     "git@git.lint.to:#{user.slug}/#{slug}.git"
                   end
  end

  def pretty_uuid
    if uuid.present?
      splitted_uuid = uuid.split('/')
      @pretty_uuid = "#{splitted_uuid.first} / #{splitted_uuid.last}"
    else
      @pretty_uuid = '-'
    end
  end

  def pretty_uuid_html
    if uuid.present?
      splitted_uuid = uuid.split('/')
      @pretty_uuid_html = "#{splitted_uuid.first} / <strong>#{splitted_uuid.last}</strong>"
    else
      @pretty_uuid_html = '-'
    end
  end

  # before_save do
  #
  #   @output1 = ""
  #   @output2 = ""
  #   @output3 = ""
  #   @output4 = ""
  #   @output5 = ""
  #   @output6 = ""
  #   @output7 = ""
  #   Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
  #     @output1 << ssh.exec!("ls /var/git")
  #     @output2 << ssh.exec!("mkdir /var/git/#{self.user.slug}")
  #     @output3 << ssh.exec!("ls /var/git")
  #     @output4 << ssh.exec!("ls /var/git/#{self.user.slug}")
  #     @output5 << ssh.exec!("mkdir /var/git/#{self.user.slug}/#{self.slug}.git")
  #     @output6 << ssh.exec!("git --bare init /var/git/#{self.user.slug}/#{self.slug}.git")
  #     @output7 << ssh.exec!("ls /var/git/#{self.user.slug}/#{self.slug}.git")
  #   end
  #
  # end

  # before_create :deploy
  def deploy
    return unless git_host == LINT_GIT_HOST

    # Create git repository
    Rails.logger.info 'Connecting to SSH...'
    Net::SSH.start(
      ENV.fetch('GIT_SERVER_HOST', 'git.lint.to'),
      ENV.fetch('GIT_SERVER_USER', 'root'),
      password: ENV.fetch('GIT_SERVER_PASSWORD', '')
    ) do |_ssh|
      Rails.logger.info 'Connected to SSH.'
      # Creat user directory if needed
      # puts ssh.exec!("mkdir -p /var/git/#{self.user.slug}")
      # puts 'Creat user directory if needed'
      # Create repo directory if needed
      # puts ssh.exec!("rm -rf /var/git/#{self.user.slug}/#{self.slug}.git")
      Rails.logger.info 'Creating repository directory...'
      # puts ssh.exec!("mkdir /var/git/#{self.user.slug}/#{self.slug}.git")
      Rails.logger.info ssh.exec!("mkdir -p /var/git/#{user.slug}/#{slug}.git")
      # Create bare repo
      Rails.logger.info 'Creating bare repository'
      Rails.logger.info ssh.exec!("git --bare init /var/git/#{user.slug}/#{slug}.git")
      Rails.logger.info ssh.exec!("chmod -R 777 /var/git/#{user.slug}/#{slug}.git")
      # Local deploy repo
      Rails.logger.info 'Deploying repository...'
      Rails.logger.info ssh.exec!("rm -rf /var/git/#{user.slug}/#{slug}")
      Rails.logger.info ssh.exec!("git clone /var/git/#{user.slug}/#{slug}.git /var/git/#{user.slug}/#{slug}")
      Rails.logger.info ssh.exec!("chmod -R 777 /var/git/#{user.slug}/#{slug}")

      # Copy and replace post-receive hook
      Rails.logger.info 'Adding post-receive hook...'
      Rails.logger.info ssh.exec!("cp -f /var/git/_permanent/post-receive /var/git/#{user.slug}/#{slug}.git/hooks/post-receive")
      Rails.logger.info ssh.exec!("sed -i 's/USER_SLUG/#{user.slug}/g' /var/git/#{user.slug}/#{slug}.git/hooks/post-receive")
      Rails.logger.info ssh.exec!("sed -i 's/REPOSITORY_SLUG/#{slug}/g' /var/git/#{user.slug}/#{slug}.git/hooks/post-receive")
      Rails.logger.info ssh.exec!("chmod +x /var/git/#{user.slug}/#{slug}.git/hooks/post-receive")

      Rails.logger.info "Repository #{user.slug}/#{slug} deployed successfully."

      # ssh.exec!("git --work-tree=/var/git/#{self.user.slug}/#{self.slug} --git-dir=/var/git/#{self.user.slug}/#{self.slug}.git checkout -f")
    end
  end

  # You likely have this before callback set up for the token.
  before_validation :ensure_uuid
  after_create :create_repository_access
  def create_repository_access
    return if user.blank?

    RepositoryAccess.create!({
                               repository: self,
                               user: user,
                               role: 'admin'
                             })
  end

  # before_validation :ensure_uuid

  def ensure_uuid
    self.uuid = generate_uuid if uuid.blank?
    return if secret_key.present?

    self.secret_key = generate_secret_key
  end

private

  def generate_uuid
    # uuid = "12345-00000-00000-#{10000 + self.id}"
    "#{user.slug}/#{slug}"
  end

  def generate_secret_key
    require 'securerandom'
    SecureRandom.hex(30)
  end
end
