class UserMailer < ApplicationMailer

  # default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    # @site_url  = 'https://gatrix.io'
    # @login_url  = 'https://gatrix.io/login'
    @site_url  = 'https://gatrix.io'
    @login_url  = 'https://gatrix.io/login'
    mail(from: "Gatrix <support@gatrix.io>", to: "#{@user.username} <#{@user.email}>", subject: "Welcome to Gatrix, #{@user.username}")
  end

  def commit_attempt_report(commit_attempt)
    @commit_attempt = commit_attempt
    @user = @commit_attempt.user
    @repository = @commit_attempt.repository
    # @repository_accesses = @user.repository_accesses.where(repository: repository)
    @repository_accesses = @repository.repository_accesses.where(user: @user)

    if @repository_accesses.count > 0
      @repository_access = @repository_accesses.first
      @javascript_logo_url = '/images/platformicons/svg/javascript.svg'
      @ruby_logo_url = '/images/platformicons/svg/ruby.svg'
      @generic_logo_url = '/images/platformicons/svg/generic.svg'
      if @commit_attempt.policy_checks.first.present?
        @policy_check = @commit_attempt.policy_checks.first
      else
        @policy_check = nil
      end
      @site_url  = 'https://gatrix.io'
      @login_url  = 'https://gatrix.io/login'

      if @repository_access.enable_email_notifications
        mail(from: "Gatrix <support@gatrix.io>", to: "#{@user.username} <#{@user.email}>", subject: "#{@repository.uuid} - #{@commit_attempt.name}")
      end

      if @repository_access.enable_admin_email_notifications
        @repository.repository_accesses.each do |access|
          if access.role == 'admin' && access.user.username != @user.username
            mail(from: "Gatrix <support@gatrix.io>", to: "#{access.user.username} <#{access.user.email}>", subject: "#{@repository.uuid} - #{@commit_attempt.name}")
          end
        end
      end

    end

  end

end
