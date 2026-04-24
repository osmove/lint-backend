class MessageMailer < ApplicationMailer
  # default from: 'notifications@example.com'

  def message_created_email(message)
    @message = message
    @site_url = 'https://lint.to'
    @login_url = 'https://lint.to/login'

    # Send email to client
    # mail(from: "Lint <support@lint.to>", to: "<#{message.to_email}>", subject: "New message: '#{message.subject}'")
    mail(from: 'Lint <support@lint.to>', to: 'jimmydouieb@gmail.com', subject: "New message: '#{message.subject}'")

    # Send copy
    # mail(from: "Lint <support@lint.to>", to: "Jimmy Douieb <jimmydouieb@gmail.com>", subject: "Repository '#{@repository.user.username}/#{@repository.name}' was created successfully.")
  end
end
