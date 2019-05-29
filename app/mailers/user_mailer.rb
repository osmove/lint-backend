class UserMailer < ApplicationMailer

  # default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    # @site_url  = 'https://lint.dev'
    # @login_url  = 'https://lint.dev/login'
    @site_url  = 'https://lint.dev'
    @login_url  = 'https://lint.dev/login'
    mail(from: "Omnilint <support@omnilint.com>", to: "#{@user.username} <#{@user.email}>", subject: "Welcome to Omnilint, #{@user.username}")
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
        if @policy_check.report["rule_checks_attributes"].present?
          @report = @policy_check.report["rule_checks_attributes"].sort_by!{|h| [h["security_level"] ? h["security_level"] : 0]}.group_by{ |h| [h['file_path']] }
        else
          @report = nil
        end

      else
        @policy_check = nil
      end
      @site_url  = 'https://lint.dev'
      @login_url  = 'https://lint.dev/login'

      if @repository_access.enable_email_notifications
        mail(from: "Omnilint <support@omnilint.com>", to: "#{@user.username} <#{@user.email}>", subject: "[#{@repository.uuid}] #{@commit_attempt.name}")
      end

      if @repository_access.enable_admin_email_notifications
        @repository.repository_accesses.each do |access|
          if access.role == 'admin' && access.user.username != @user.username
            mail(from: "Omnilint <support@omnilint.com>", to: "#{access.user.username} <#{access.user.email}>", subject: "[#{@repository.uuid}] #{@commit_attempt.name}")
          end
        end
      end

    else
      if @commit_attempt.policy_checks.first.present?
      @policy_check = @commit_attempt.policy_checks.first
      @report = @policy_check.report["rule_checks_attributes"].sort_by!{|h| [h["security_level"] ? h["security_level"] : 0]}.group_by{ |h| [h['file_path']] }
      else
        @policy_check = nil
        @report = nil
      end
      mail(from: "Omnilint <support@omnilint.com>", to: "#{@user.username} <#{@user.email}>", subject: "#{@repository.uuid} - #{@commit_attempt.name}")
    end



  end

end
