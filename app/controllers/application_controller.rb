class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  # before_action :set_current_user
  
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる時
  def configure_permitted_parameters
    # 新規登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # 編集時
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image, :profile, :bunri])
  end
  
  private
  
  def check_admin
    redirect_to root_path unless current_user.try(:admin?)
  end

  # def set_current_user
  #   @current_user = User.find_by(id: session[:user_id])
  # end


  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
  
end
