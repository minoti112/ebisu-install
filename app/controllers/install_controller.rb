class InstallController < ApplicationController
  
  def index
    redirect_to "https://#{params['domain']}/#{params['ebisu_no']}/admin_authorize.html?scope=#{getScope}&response_type=code&redirect_uri=#{getRedirectUri}&client_id=EBISU_INSTALL&state=#{getStatus}"
  end

  private
  
  def getScope
    "item%20privacy%20system"
  end
  
  def getRedirectUri
    "https://ebisu-install.herokuapp.com/auth"
  end
  
  def getStatus
    
  end
end
