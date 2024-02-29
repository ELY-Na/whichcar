class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def after_sign_in_path_for(resource)
    if cookies[:search_url]
      redirect_url = cookies[:search_url]

      if cookies[:open_modal_when_sign_in]
        redirect_url += "&openModal=#{cookies[:open_modal_when_sign_in]}"
      end

      redirect_url.gsub!(';', '%3B')

      cookies[:open_modal_when_sign_in] = ''
      cookies[:search_url] = ''

      redirect_url
    else
      super
    end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^cars$)/
  end
end
