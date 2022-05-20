class HomeController < ApplicationController
  before_action :is_authenticate, only: [:index]

  def index  
  end

  private
  def is_authenticate
    if session[:current_user_name] && session[:current_user_email] && session[:current_user_password]
      redirect_to dashboard_index_path
    else
      redirect_to login_index_path
    end
  end
end