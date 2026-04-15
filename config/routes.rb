Rails.application.routes.draw do

  # API v1 (JSON, token auth)
  namespace :api do
    namespace :v1 do
      post 'lint', to: 'lint#create'
      post 'review', to: 'review#create'
      post 'repositories/:repository_uuid/recommend', to: 'recommend#create'
      post 'policies/generate', to: 'policies#generate'
    end
  end

  post 'postmark/inbound'

  resources :policy_rule_options
  resources :linters
  get 'search/search'

  get 'search/search_repositories'

  get 'search/search_users'

  get 'hooks/post_receive'

  resources :hosting_plans
  resources :platforms
  resources :devices
  resources :repository_accesses
  resources :plans
  resources :contributors
  resources :branches
  resources :organizations
  resources :servers
  resources :dependancies
  resources :frameworks
  resources :languages
  resources :charges

  # TODO: Remove
  # resources :users
  resources :repositories
  resources :decryptions
  resources :encryptions
  resources :buildpacks
  resources :buttons
  resources :commands
  resources :issue_messages
  resources :issues
  resources :deploys
  resources :syncs
  resources :pulls
  resources :pushes
  resources :changes
  resources :commits

  resources :users, except: [:destroy, :show, :create]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get "/auth/:provider/callback" => "pages#dashboard"

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    # get '/edit' => 'devise/registrations#edit'
  end

  resources :users, only: [:destroy, :show, :create]


  # devise_for :pages, class_name: 'User', only: [], controllers: { registrations: "pages/home", confirmations: 'confirmations' }


  resources :teams
  get '/contact', to: 'messages#new'
  get '/messages/thank-you', to: 'messages#thank_you'
  resources :messages



  #resources :documents

  get 'admin', to: 'admin/base#dashboard'
  namespace :admin do
    resources :users
    get '/organizations', to: 'users#organizations_index'
    get '/teams' => 'teams#index', :as => :admin_user_teams

    resource :user, path: "/users/:id" do
      get '/policies' => 'users#user_policies'
      get '/organizations' => 'users#user_organizations'
      get '/members' => 'users#organization_members'
      get '/teams' => 'users#organization_teams'

    end

    resources :teams do
      resources :memberships, path: "/members"
        resource :membership, path: "/members/:_id", only: [:show, :destroy, :edit]  do
      end
    end

    resource :repository, only: [:index, :new]
    resources :repositories
    resource :repository, path: "repositories/:repository_id", only: [:show, :destroy, :delete, :qr_code] do
      get '/commits/index_ssh', to: 'commits#index_ssh'
      resources :commit_attempts
      resources :commits
      get '/documents/:id/show_ssh', to: 'documents#show_ssh'
      get '/documents/index_ssh', to: 'documents#index_ssh'
      get '/documents/:id' => 'documents#show', :constraints => { :id => /.*/ }
      get '/tree/:id' => 'documents#show', :constraints => { :id => /.*/ }
      get '/blob/:id' => 'documents#show', :constraints => { :id => /.*/ }
      resources :documents, :constraints => { :id => /.*/ }
      resources :documents
      resources :decryptions
      resources :encryptions
      resources :repository_accesses, path: 'access'

    end
    resources :decryptions
    resources :encryptions
    resources :pushes
    resources :devices
    resources :plans
    resources :teams
    resources :memberships
    resources :contributors
    resources :commits, path: "/commits"
    resources :documents, path: "/documents"
    resources :repository_accesses
    resources :platforms
    resources :frameworks
    resources :languages
    resources :rules
    resources :policies
    resources :policy_rules
    resources :rule_checks
    resources :policy_checks
    resources :commit_attempts
    resources :hosting_plans
    resources :linters

  end

  resources :rule_checks
  resources :policy_checks
  resources :commit_attempts
  resources :policy_rules
  resources :rules
  resources :policies

  post '/devices/push-token' => 'devices#push_token'

  get '/apps'         => 'pages#apps'
  get '/docs'         => 'pages#docs'
  get '/cloud'        => 'pages#cloud'
  get '/deploy'       => 'pages#deploy'
  get '/terms'        => 'pages#terms'
  get '/privacy'      => 'pages#privacy'
  get '/help'         => 'pages#help'
  get '/features'     => 'pages#features'
  get '/security'     => 'pages#security'
  get '/pricing'      => 'pages#pricing'
  get '/faq'          => 'pages#faq'
  get '/download'     => 'pages#downloads'
  get '/downloads'    => 'pages#downloads'

  get '/is_signed_in'  => 'auth#is_signed_in?'
  get '/me'            => 'auth#me'
  get '/team'          => 'pages#team'
  # get '/contact'       => 'pages#contact'
  get '/privacy'       => 'pages#privacy'
  get '/terms'         => 'pages#terms'
  get '/security'      => 'pages#security'
  get '/about'         => 'pages#about'

  get '/desktop'        => 'pages#desktop'
  get '/connect'        => 'pages#connect'
  get '/cli'            => 'pages#cli'
  get '/npm'            => 'pages#npm'
  get '/prelaunch'      => 'pages#prelaunch'
  get '/home'           => 'pages#home'
  get '/github_repos'           => 'pages#github_repos'
  get '/onboarding/step_1' => 'pages#select_repositories'


  authenticated :user do
    get '/dashboard'            => 'pages#dashboard'
    root to: "pages#dashboard", as: :authenticated_root
  end

  # get '/users' => 'users#index', :as => :users

  get '/login' => 'devise/sessions#new'

  resource :user, path: "/:user_id" do
    get '/edit' => 'users#edit', :as => :user_edit
    # get '/policies' => 'policies#user_policies'
    resources :policies

    # get '/edit' => 'devise/registrations#edit', :as => :user_edit
    get '/repositories' => 'repositories#index', :as => :user_repositories
    resources :repository_accesses
    resources :teams
    # resources :organizations
    # get '/teams' => 'teams#index', :as => :user_teams

    resources :organizations

    resources :teams do
      resources :memberships, path: "/members"
        resource :membership, path: "/members/:_id", only: [:show, :destroy, :edit]  do
      end
    end

    # resource :repository, path: "/:id", only: [:show, :destroy, :delete]
    # resource :repository, path: "/:repository_id", only: [:show, :destroy, :delete, :qr_code] do
    # resource :repository, path: "/:repository_id", only: [:show, :update, :create, :edit, :destroy, :delete, :qr_code] do
    resource :repository, path: "/:repository_id", except: [:index, :new] do

      get :qr_code
      # get '/documents' => 'documents#index', :as => :user_repository_documents
      get '/settings' => 'repositories#settings'
      # get '/access' => 'repositories#access'

      get '/documents/:id' => 'documents#show', :constraints => { :id => /.*/ }
      get '/tree/:id' => 'documents#show', :constraints => { :id => /.*/ }
      get '/blob/:id' => 'documents#show', :constraints => { :id => /.*/ }

      resources :documents, :constraints => { :id => /.*/ }
      resources :repository_accesses, path: 'access'
      resources :issues
      resources :commits
      get '/policy' => 'repositories#repository_policies'
      resources :policies
      resources :pull_requests
      resources :commit_attempts
      resources :analytics
      resources :ratings
      resources :settings
      resources :deploys
      resources :syncs
      resources :pulls
      resources :pushes
      resources :changes
      resources :buttons
      resources :commands
      resources :decryptions
      resources :encryptions
      resources :buildpacks
    end

    resources :repositories, path: "/repositories"
    resources :commits, path: "/commits"
    # resources :organizations, path: "/organizations"
    resources :teams, path: "/teams"
    resources :policies, path: "/policies"



  end



  root to: "pages#prelaunch"
  #root to: "pages#home"
  # root to: "pages#available_soon"

end
