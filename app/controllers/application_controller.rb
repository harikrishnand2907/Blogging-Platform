class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? && (controller_name == 'sessions' || controller_name == 'registrations')
      'auth'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    posts_path # Redirect to blog page after login
  end

  def after_sign_up_path_for(resource)
    posts_path # Redirect to blog page after signup
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirect to login page after logout
  end
end
