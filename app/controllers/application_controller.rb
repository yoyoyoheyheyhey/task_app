class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :login_check

  def login_check
    redirect_to new_session_path unless logged_in?
  end
end
