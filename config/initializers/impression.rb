# Use this hook to configure impressionist parameters
# Impressionist relies on Rack session internals that changed in newer Rack/Rails
# versions. In test and anonymous requests the session ID can be nil, so guard
# the legacy cookie_value access and simply skip the session hash in that case.
module ImpressionistSessionHashCompatibility
  def session_hash
    id = request.session_options[:id]
    return if id.blank?

    if defined?(Rack::Session::SessionId) &&
       Rack::Session::SessionId.const_defined?(:ID_VERSION) &&
       Rack::Session::SessionId::ID_VERSION == 2 &&
       id.respond_to?(:cookie_value)
      return id.cookie_value
    end

    id
  end
end

Rails.application.config.to_prepare do
  ImpressionistController.prepend(ImpressionistSessionHashCompatibility)
end


