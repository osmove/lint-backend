class Repository < ApplicationRecord

  require 'net/ssh'

  include ActionView::Helpers::DateHelper

  belongs_to :user

  belongs_to :policy, optional: true
  belongs_to :platform, optional: true
  belongs_to :hosting_plan, optional: true

  has_many :buildpacks, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :commits, :dependent => :destroy
  has_many :commands, :dependent => :destroy
  # has_many :changes, :dependent => :destroy, :as => :changed_files
  has_many :buttons, :dependent => :destroy
  has_many :pulls, :dependent => :destroy
  has_many :pushs, :dependent => :destroy
  has_many :syncs, :dependent => :destroy
  has_many :deploys, :dependent => :destroy
  has_many :issues, :dependent => :destroy
  has_many :encryptions, :dependent => :destroy
  has_many :decryptions, :dependent => :destroy
  has_many :repository_accesses, :dependent => :destroy
  has_many :commit_attempts, :dependent => :destroy

  has_many :policy_checks
  has_many :rules_checks

  has_many :users
  # has_many :users_with_access, :through => :repository_accesses
  has_many :users_with_access, :through => :repository_accesses, :source => :user
  # has_many :repositories, :through => :repository_accesses

  extend FriendlyId
  friendly_id :name, :use => :scoped, :scope => :user

  # validates :domain_slug, presence: true, uniqueness: { case_sensitive: false }, if: -> { deploy_to == 'omnilint_cloud' && domain_slug.blank? }

  validates :domain_slug, presence: true, if: -> { deploy_to == 'omnilint_cloud' }
  # validates :domain_slug, uniqueness: { case_sensitive: false }, if: -> { deploy_to == 'omnilint_cloud' && domain_slug.present? }
  validates :domain_slug, uniqueness: { case_sensitive: false }, if: -> { deploy_to == 'omnilint_cloud' && domain_slug.present? }

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

  validates :deploy_to, presence: true


  self.inheritance_column = :_type_disabled


  # is_impressionable
  is_impressionable :counter_cache => true, :column_name => :counter_cache


  def to_s
    self.name
  end


  def smart_created_at
    if self.platform.present?
      if self.git_host == "github"
        "#{self.platform} app created #{time_ago_in_words(self.github_created_at)} ago."
      else
        "#{self.platform} app created #{time_ago_in_words(self.created_at)} ago."
      end
    else
      if self.git_host == "github"
        "Created #{time_ago_in_words(self.github_created_at)} ago."
      else
        "Created #{time_ago_in_words(self.created_at)} ago."
      end
    end
  end

  # after_create :send_created_email
  # def send_created_email
  #   RepositoryMailer.repository_created_email(self).deliver_now
  # end

  def self.public
    self.where(status: "Public")
  end

  def self.private
    self.where(status: "Private")
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  # def normalize_friendly_id(value)
  #   value.to_s.parameterize(separator: "-", preserve_case: false)
  # end


  def git_address
    if self.git_host != "github"
      @git_address = "git@git.omnilint.com:#{self.user.slug}/#{self.slug}.git"
    else
      @git_address = self.git_url
    end
  end

  def pretty_uuid
    splitted_uuid = self.uuid.split("/")
    @pretty_uuid = "#{splitted_uuid.first} / #{splitted_uuid.last}"
  end


  def pretty_uuid_html
    splitted_uuid = self.uuid.split("/")
    @pretty_uuid_html = "#{splitted_uuid.first} / <strong>#{splitted_uuid.last}</strong>"
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
  #   Net::SSH.start('git.omnilint.com', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
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
    if self.git_host == "omnilint"
      # Create git repository
      puts 'Connecting to SSH...'
      Net::SSH.start('git.omnilint.com', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
        puts 'Connected to SSH.'
        # Creat user directory if needed
        # puts ssh.exec!("mkdir -p /var/git/#{self.user.slug}")
        # puts 'Creat user directory if needed'
        # Create repo directory if needed
        # puts ssh.exec!("rm -rf /var/git/#{self.user.slug}/#{self.slug}.git")
        puts 'Creating repository directory...'
        # puts ssh.exec!("mkdir /var/git/#{self.user.slug}/#{self.slug}.git")
        puts ssh.exec!("mkdir -p /var/git/#{self.user.slug}/#{self.slug}.git")
        # Create bare repo
        puts 'Creating bare repository'
        puts ssh.exec!("git --bare init /var/git/#{self.user.slug}/#{self.slug}.git")
        puts ssh.exec!("chmod -R 777 /var/git/#{self.user.slug}/#{self.slug}.git")
        # Local deploy repo
        puts 'Deploying repository...'
        puts ssh.exec!("rm -rf /var/git/#{self.user.slug}/#{self.slug}")
        puts ssh.exec!("git clone /var/git/#{self.user.slug}/#{self.slug}.git /var/git/#{self.user.slug}/#{self.slug}")
        puts ssh.exec!("chmod -R 777 /var/git/#{self.user.slug}/#{self.slug}")

        # Copy and replace post-receive hook
        puts 'Adding post-receive hook...'
        puts ssh.exec!("cp -f /var/git/_permanent/post-receive /var/git/#{self.user.slug}/#{self.slug}.git/hooks/post-receive")
        puts ssh.exec!("sed -i 's/USER_SLUG/#{self.user.slug}/g' /var/git/#{self.user.slug}/#{self.slug}.git/hooks/post-receive")
        puts ssh.exec!("sed -i 's/REPOSITORY_SLUG/#{self.slug}/g' /var/git/#{self.user.slug}/#{self.slug}.git/hooks/post-receive")
        puts ssh.exec!("chmod +x /var/git/#{self.user.slug}/#{self.slug}.git/hooks/post-receive")

        puts "Repository #{self.user.slug}/#{self.slug} deployed successfully."

        # ssh.exec!("git --work-tree=/var/git/#{self.user.slug}/#{self.slug} --git-dir=/var/git/#{self.user.slug}/#{self.slug}.git checkout -f")
      end
    end
  end



  after_create :create_repository_access
  def create_repository_access
    if self.user.present?
      RepositoryAccess.create!({
        repository: self,
        user: self.user,
        role: 'admin',
      })
    end
  end



  # You likely have this before callback set up for the token.
  before_validation :ensure_uuid
  # before_validation :ensure_uuid

  def ensure_uuid
    if self.uuid.blank?
      self.uuid = generate_uuid
    end
    if self.secret_key.blank?
      self.secret_key = generate_secret_key
    end
  end

  private

  def generate_uuid
    # uuid = "12345-00000-00000-#{10000 + self.id}"
    uuid = "#{self.user.slug}/#{self.slug}"
  end

  def generate_secret_key
    # loop do
    #   secret_key = rand(100000...999999)
    #   break secret_key unless Device.where(secret_key: secret_key).first
    # end
    # secret_key = rand(100000...999999)

    # require 'SecureRandom'
    require 'securerandom'
    # secret_key = SecureRandom.hex()
    secret_key = SecureRandom.hex(30)
  end



end
