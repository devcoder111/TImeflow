class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout
  before_action :authenticate_user!, :set_current_user

  def set_project
    @project ||= current_user_projects.find params[:project_id]
  end

  def current_user_projects
    current_user.organisation.projects
  end

  def after_sign_in_path_for(resource = nil)
     current_user_projects.present? ? projects_path : root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :company_name, :email, :password, :password_confirmation) }
    end

  private
    def layout
      # only turn it off for login pages:
      if is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController)
        "login"
      else
        "application"
      end
      # or turn layout off for every devise controller:
      #devise_controller? && "application"
    end

    def set_current_user
      User.current = current_user
    end
end
