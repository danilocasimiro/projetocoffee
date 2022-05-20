class LoginController < ApplicationController
  def index
  end

  def create
    if session[:users].present? && email_and_password_is_valid?
      redirect_to(dashboard_index_path, { flash: { notice: "Login realizado com sucesso!" } } )
    else
      flash.now.alert = "Email ou senha inválidos!"
      render :index
    end
  end

  def destroy
    session[:current_user_name] = nil
    session[:current_user_email] = nil
    session[:current_user_password] = nil

    redirect_to login_index_path
  end

  private
  def email_and_password_is_valid?
    session[:users].each do |user|
      if user['email'] == params['email'] && user['password'] == params['password']
        insert_user_in_current_session(user)
        return true
      end
    end

    return false
  end

  def insert_user_in_current_session(user)
    session[:current_user_name] = user['name']
    session[:current_user_email] = user['email']
    session[:current_user_password] = user['password']
  end
end