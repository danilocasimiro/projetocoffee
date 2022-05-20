class DashboardController < ApplicationController
  before_action :is_authenticate, only: [:index]
  require 'rest-client'
  
  def index
    @localization = JSON.parse(RestClient.get("http://ipinfo.io/#{request.remote_ip}/geo", headers={}))
  end

  private
  def is_authenticate
    redirect_to login_index_path if session[:current_user_email].blank?
  end
end