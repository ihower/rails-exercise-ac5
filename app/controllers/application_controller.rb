class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :log_current_user
  before_action :set_locale
  before_action :set_timezone

  helper_method :current_cart

  protected

  def current_cart
    @cart || set_cart
  end

  def set_cart
    if session[:cart_id]
      @cart = Cart.find_by_id( session[:cart_id] )
    end

    @cart ||= Cart.create!
    session[:cart_id] = @cart.id

    return @cart
  end

  # Pro Tip:
  # true || "不會執行"
  # false && "不會執行"
  def set_timezone
    if current_user && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def log_current_user
    if current_user
      Rails.logger.info "current_user_id: #{current_user.id}"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :time_zone

    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :time_zone
  end


end
