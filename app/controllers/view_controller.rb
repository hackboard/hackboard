class ViewController < ApplicationController

  def index
    check_remember
  end

  def check_remember
    if not cookies[:remember_token].nil?
      if not current_user.nil?
        #refresh remember token
        remember @current_user
        redirect_to '/boards'
      else
        Rails.logger.debug('No current user...')
      end
    end

  end

end
