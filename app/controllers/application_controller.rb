class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "#{request.env['HTTP_ACCEPT_LANGUAGE'].inspect}"
    logger.debug "regex:#{extract_locale_from_accept_language_header}"
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
 
  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].match(/[a-z]{2}(-[A-Z]{2})?/).to_s
  end
end
