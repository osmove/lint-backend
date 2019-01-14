class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: User.first).welcome_email(User.first)
  end

  def commit_attempt_report
    UserMailer.with(user: User.first).commit_attempt_report(User.first.commit_attempts.last.policy_checks.first)
  end
end
