class RepositoryMailer < ApplicationMailer

  # default from: 'notifications@example.com'

  def repository_created_email(repository)
    @repository = repository
    @site_url  = 'https://www.omnilint.com'
    @login_url  = 'https://www.omnilint.com/login'

    # Send email to client
    mail(from: "Lint.dev <support@lint.dev>", to: "#{@repository.user.username} <#{@repository.user.email}>", subject: "Your repository '#{@repository.name}' was created successfully")

    # Send copy
    # mail(from: "Lint.dev <support@lint.dev>", to: "Jimmy Douieb <jimmydouieb@gmail.com>", subject: "Repository '#{@repository.user.username}/#{@repository.name}' was created successfully.")

  end

end
