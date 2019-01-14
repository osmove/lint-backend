class RepositoryMailer < ApplicationMailer

  # default from: 'notifications@example.com'

  def repository_created_email(repository)
    @repository = repository
    @site_url  = 'https://gatrix.io'
    @login_url  = 'https://gatrix.io/login'

    # Send email to client
    mail(from: "Gatrix <support@gatrix.io>", to: "#{@repository.user.username} <#{@repository.user.email}>", subject: "Your repository '#{@repository.name}' was created successfully")

    # Send copy
    # mail(from: "Gatrix <support@gatrix.io>", to: "Jimmy Douieb <jimmydouieb@gmail.com>", subject: "Repository '#{@repository.user.username}/#{@repository.name}' was created successfully.")

  end

end
