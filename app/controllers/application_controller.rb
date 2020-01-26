class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? #本番環境でのみvasic_authが実行される
  protect_from_forgery with: :exception

  private

  def production? #このメソッドをbefore_actionに記述する
    Rails.env.production? #現在の環境が本番ならtrue,違えばfalseを返す
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"] #環境変数にして開発、本番環境にvimで定義する
    end
  end
end
