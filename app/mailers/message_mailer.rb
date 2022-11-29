class MessageMailer < ApplicationMailer

  # default from: 'notifications@example.com'

  def message_created_email(message)
    @message = message
    @site_url  = 'https://www.omnilint.com'
    @login_url  = 'https://www.omnilint.com/login'

    # Send email to client
    # mail(from: "Lint.dev <support@omnilint.com>", to: "<#{message.to_email}>", subject: "New message: '#{message.subject}'")
    mail(from: "Lint.dev <support@omnilint.com>", to: "jimmydouieb@gmail.com", subject: "New message: '#{message.subject}'")

    # Send copy
    # mail(from: "Lint.dev <support@omnilint.com>", to: "Jimmy Douieb <jimmydouieb@gmail.com>", subject: "Repository '#{@repository.user.username}/#{@repository.name}' was created successfully.")

  end

end
