class ConfirmationsController < Devise::ConfirmationsController
private

  def after_confirmation_path_for(_resource_name, _resource)
    # your_new_after_confirmation_path
    root_path
  end
end
