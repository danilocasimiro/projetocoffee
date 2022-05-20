class RegistersController < ApplicationController
  def index
  end

  def create
    session[:users] = [] if session[:users].blank?
    
    if !load_user
      render :index 
    else 
      session[:users] <<
        { 
          name: @user.name,
          email: @user.email,
          password: @user.password
        }

      insert_user_in_current_session

      redirect_to login_index_path
    end
  end

  private
  def insert_user_in_current_session
    session[:current_user_name] = params[:name]
    session[:current_user_email] = params[:email]
    session[:current_user_password] = params[:password]
  end

  def load_user
    @user = User.new
    @user.name = params['name']
    @user.email = params['email']
    @user.password = params['password']

   
    @user.valid?
    email_is_unique
    @user.errors.blank?
  end

  def email_is_unique
    return true if session[:users].blank?

    session[:users].each do |user|
      if params[:email].present? && user['email'] == params[:email]
        @user.errors.add(:email, 'já se encontra em uso.')
        return
      end
    end
  end
end