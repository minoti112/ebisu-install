class AuthController < ApplicationController
  
  def index
    
    logger.debug(params)
    
    # インストール不許可
    if params['error'] || !params['domain'] || !params['ebisu_no']
      render template: 'welcome/index'
      return
    end
    
    # ステータスのチェック
    if params['state'] != cookies[:state]
      render template: 'welcome/index'
      return
    end
    
    # トークン取得
    client = Faraday.new(:url => "https://#{params['domain']}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
      faraday.basic_auth 'EBISU_INSTALL', Rails.application.secrets.ebisu_app_password
    end
    res = client.post "#{params['ebisu_no']}/app_oauth/access_token.html", {
      :grant_type => :authorization_code,
      :code => params['code'],
      :redirect_uri => getRedirectUri,
      :client_id => :EBISU_INSTALL
    }
    body = JSON.parse(res.body)
    
    logger.debug("start logger")
    logger.debug(body)
    logger.debug("end logger")
    
    if body["error"]
      flash[:errorMsg] = body["error"]
    else 
      # リフレッシュトークンの保存
      app_client = AppClient.new
      app_client.clinet_no = body["shop_id"]
      app_client.refresh_token = body["refresh_token"]
      app_client.save
    end
    

  end

  private
  def getRedirectUri
    "https://#{Rails.application.secrets.ebisu_app_host}/auth?ebisu_no=#{params['ebisu_no']}&domain=#{params['domain']}"
  end
end
