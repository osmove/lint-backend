class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  require "open-uri"
  require "json"

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    #fetch repositories
    omniauth = request.env['omniauth.auth']

    if @user.persisted? || @user.save

      if @user.oauth_token != omniauth.credentials.token || @user.token_expires_at.present? && @user.token_expires_at.datetime < DateTime.now
        @user.oauth_token = omniauth.credentials.token
        @user.token_expires_at = omniauth.credentials.expires_at
        # puts(omniauth.credentials.token)
        @user.github_username = omniauth.extra.raw_info.login
        # puts(omniauth.extra.raw_info.login)
        @user.github_id = omniauth.extra.raw_info.id
        # puts(omniauth.extra.raw_info.id)
      end

      if @user.avatar_url.blank?
        @user.avatar_url = omniauth.extra.raw_info.avatar_url
      end

      # Fetch repositories
      repositories_json = open(omniauth.extra.raw_info.repos_url,
        "Accept" => "application/vnd.github.v3+json",
        "Authorization" => "token #{omniauth.credentials.token}"
      ).read

      repositories = JSON.parse(repositories_json)
      if repositories.count > 0
        repositories.each do |repo|
          if Repository.where(user: @user, web_address: repo['html_url'], git_address: repo['git_url']).blank?
            if repo['owner']["login"] == @user.login
              if repo['language'].present?
                @platform = Platform.where(slug: repo['language'].downcase).first rescue nil
              else
                @platform = Platform.where(name: "Other").first rescue nil
              end

              if repo['private'] == true
                @repository = @user.repositories.new(name: repo['name'], slug: repo['name'], user_id: repo['owner']["login"].downcase, status: "Private", web_address: repo['html_url'], git_address: repo['git_url'], platform: @platform, deploy_to: 'none', git_url: repo['git_url'],
                web_url: repo['html_url'],
                ssh_url: repo['ssh_url'],
                github_updated_at: repo['updated_at'],
                github_created_at: repo['created_at'],
                imported_at: DateTime.now,
                git_host: "github",
                is_archived: false,
                size: repo['size'],
                has_downloads: repo['has_downloads'],
                has_wiki: repo['has_wiki'],
                is_ignored: false)
              else
                @repository = @user.repositories.new(name: repo['name'], slug: repo['name'], user_id: repo['owner']["login"].downcase, status: "Public", web_address: repo['html_url'], git_address: repo['git_url'], platform: @platform, deploy_to: 'none', git_url: repo['git_url'],
                web_url: repo['html_url'],
                ssh_url: repo['ssh_url'],
                github_updated_at: repo['updated_at'],
                github_created_at: repo['created_at'],
                imported_at: DateTime.now,
                git_host: "github",
                is_archived: false,
                size: repo['size'],
                has_downloads: repo['has_downloads'],
                has_wiki: repo['has_wiki'],
                is_ignored: false)
              end

              if !@repository.save!
                puts(@repository.errors.full_messages)
              else
                # Save commit data
                # commits_json = open(repo["commits_url"].slice(/.*commits/)).read rescue nil
                # if commits_json != nil
                #   commits = JSON.parse(commits_json)
                #   commits.each do |commit|
                #     if !Commit.where(sha: commit["sha"]).present?
                #       @contributor = Contributor.where(email: commit["commit"]["author"]["email"], repository: @repository).first
                #       if !@contributor.present?
                #         @contributor = Contributor.new(name: commit["commit"]["author"]["name"], email: commit["commit"]["author"]["email"], repository: @repository)
                #         if !@contributor.save!
                #           puts(@contributor.errors.full_messages)
                #         end
                #       end
                #       @commiter_user = User.where(email: commit["commit"]["author"]["email"]).first
                #       if @commiter_user.present?
                #         @contributor.user = @commiter_user
                #       end
                #
                #       @commit = @repository.commits.new(
                #         message: commit["commit"]["message"],
                #         date: commit["commit"]["author"]["date"],
                #         date_raw: commit["commit"]["author"]["date"],
                #         contributor_raw: @contributor,
                #         contributor_name: @contributor.name_or_username,
                #         contributor_email: @contributor.email,
                #         contributor: @contributor,
                #         user: @commiter_user,
                #         sha: commit["sha"]
                #       )
                #       if !@commit.save!
                #         puts(@commit.errors.full_messages)
                #       end
                #     end
                #   end
                # end
              end
            end
          end
          # sleep 3
        end

        # Fetch organizations
        organizations_json = open(omniauth.extra.raw_info.organizations_url,
          "Accept" => "application/vnd.github.inertia-preview+json",
          "Authorization" => "token #{omniauth.credentials.token}"
        ).read

        organizations = JSON.parse(organizations_json)

        # puts(organizations)

        if organizations.count > 0
          organizations.each do |org|

            if !User.where(type: "organization", username: org["login"], is_organization: true).present?
              # @organization = Organization.new(name: org["login"], user: @user)
              @organization = User.new(login: org["login"], type: "organization", username: org["login"], avatar_url: org["avatar_url"], is_organization: true, email: "#{org["login"]}@omnilint.com")
            else
              @organization = User.where(type: "organization", username: org["login"], is_organization: true).first
            end


            #fetch organization repositories

            repositories_json = open(org["repos_url"]).read

            repositories = JSON.parse(repositories_json)

            if repositories.count > 0
              repositories.each do |repo|
                if Repository.where(user_id: @organization, slug: repo['name'], web_address: repo['html_url'], git_address: repo['git_url']).blank?
                  #puts(repo)
                  if repo['language'].present?
                    @platform = Platform.where(slug: repo['language'].downcase).first rescue nil
                  else
                    @platform = Platform.where(name: "Other").first rescue nil
                  end

                  if repo['private'] == true
                    @repository = Repository.new(name: repo['name'], slug: repo['name'], user_id: @organization, status: "Private", web_address: repo['html_url'], git_address: repo['git_url'], platform: @platform, deploy_to: 'none', git_url: repo['git_url'],
                    web_url: repo['html_url'],
                    ssh_url: repo['ssh_url'],
                    github_updated_at: repo['updated_at'],
                    github_created_at: repo['created_at'],
                    imported_at: DateTime.now,
                    git_host: "github",
                    is_archived: false,
                    size: repo['size'],
                    has_downloads: repo['has_downloads'],
                    has_wiki: repo['has_wiki'],
                    is_ignored: false)
                  else
                    @repository = Repository.new(name: repo['name'], slug: repo['name'], user_id: @organization, status: "Public", web_address: repo['html_url'], git_address: repo['git_url'], platform: @platform, deploy_to: 'none', git_url: repo['git_url'],
                    web_url: repo['html_url'],
                    ssh_url: repo['ssh_url'],
                    github_updated_at: repo['updated_at'],
                    github_created_at: repo['created_at'],
                    imported_at: DateTime.now,
                    git_host: "github",
                    is_archived: false,
                    size: repo['size'],
                    has_downloads: repo['has_downloads'],
                    has_wiki: repo['has_wiki'],
                    is_ignored: false)
                  end


                  @organization.repositories.push(@repository)
                  #@github_repositories.push(@repository)

                  if !@repository.save!
                    puts(@repository.errors.full_messages)
                  else
                    # Save commit data
                    # commits_json = open(repo["commits_url"].slice(/.*commits/)).read rescue nil
                    # if commits_json != nil
                    #   commits = JSON.parse(commits_json)
                    #   commits.each do |commit|
                    #     if Commit.where(sha: commit["sha"]).blank?
                    #
                    #       @commit = @repository.commits.new(
                    #         message: commit["commit"]["message"],
                    #         date: commit["commit"]["author"]["date"],
                    #         date_raw: commit["commit"]["author"]["date"],
                    #         contributor_raw: commit["commit"]["author"]["login"],
                    #         contributor_name: commit["commit"]["author"]["name"],
                    #         contributor_email: commit["commit"]["author"]["email"],
                    #         user: @user,
                    #         sha: commit["sha"]
                    #       )
                    #       if !@commit.save!
                    #         puts(@commit.errors.full_messages)
                    #       end
                    #     end
                    #     # @repository.commits.push(@commit)
                    #   end
                    # end
                  end
                end
              end
            end



            @organization.save(validate: false)


            if !@organization.save!
              puts(@organization.errors.full_messages)

            else


              members_json = open(org["members_url"].slice(/.*members/),
              "Accept" => "application/vnd.github.v3+json",
              "Authorization" => "token #{@user.oauth_token}"
              ).read

              members = JSON.parse(members_json)
              if members.count > 0
                members.each do |member|
                  if @organization.blank?
                    @organization = User.where(type: "organization", username: org["login"], is_organization: true).first
                  end
                  @organization_member = Membership.where(username: member["login"], origin:"github", origin_url: member["url"], avatar_url: member["avatar_url"], role: member["type"]).first
                  if @organization_member.present?
                    @member = @organization.memberships.push(@organization_member)
                  else
                    @member = @organization.memberships.new(username: member["login"], origin:"github", origin_url: member["url"], avatar_url: member["avatar_url"], role: member["type"], user: @organization_member, organization_id: @organization.id)
                    puts(@member)

                    if !@member.save!
                      puts(@member.errors.full_messages)
                    end
                  end

                end
              end

              teams_json = open("https://api.github.com/orgs/#{@organization.username}/teams",
                "Accept" => "application/vnd.github.v3+json",
                "Authorization" => "token #{@user.oauth_token}"
              ).read

              if teams_json != nil
                teams = JSON.parse(teams_json)
                # puts(teams)
                teams.each do |team|
                  if Team.where(name: team["name"], user: @organization).blank?

                    @team = @organization.teams.new(
                      name: team["name"],
                      user: @organization
                    )
                    # puts(@team)
                    if !@team.save!
                      puts(@team.errors.full_messages)
                    else
                      members_json = open(team["members_url"].slice(/.*members/),
                      "Accept" => "application/vnd.github.v3+json",
                      "Authorization" => "token #{@user.oauth_token}"
                      ).read

                      members = JSON.parse(members_json)
                      if members.count > 0
                        members.each do |member|
                          @team_member = User.where(username: member["login"], github_id: member["id"]).first
                          @team_membership = Membership.where(username: member["login"], origin:"github", origin_url: member["url"], avatar_url: member["avatar_url"], role: member["type"], user: @team_member, team: @team, organization: @organization).first
                          if @team_membership.present?
                            @membership = @team.memberships.push(@team_membership)
                          else
                            @membership = @team.memberships.new(username: member["login"], origin:"github", origin_url: member["url"], avatar_url: member["avatar_url"], role: member["type"], user: @team_member, organization: @organization)
                            # puts(@membership.username)


                            if !@membership.save!
                              puts(@membership.errors.full_messages)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end


      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


  # def github
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #
  #
  #   if @user.persisted? || @user.save
  #     sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
  #   else
  #     session["devise.github_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  def failure
    redirect_to root_path
  end

end
