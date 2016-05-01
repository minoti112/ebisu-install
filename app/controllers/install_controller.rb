class InstallController < ApplicationController
  
  def index
    state = getState
    cookies[:state] = {value: state, secure: true, httponly: true}
    redirect_to "https://#{params['domain']}/#{params['ebisu_no']}/admin_authorize.html" +
      "?scope=#{getScope}" +
      "&response_type=code" +
      "&redirect_uri=#{getRedirectUri}" +
      "&client_id=EBISU_INSTALL" +
      "&state=#{state}"
  end

  private
  
  def getScope
    "item%20privacy%20system"
  end
  
  def getRedirectUri
    "https://#{Rails.application.secrets.ebisu_app_host}/auth?ebisu_no=#{params['ebisu_no']}%26domain=#{params['domain']}"
  end
  
  def getState
    require 'securerandom'
    SecureRandom.hex(16)
  end
end
