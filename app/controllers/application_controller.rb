class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? #本番環境でのみvasic_authが実行される
  before_action :set_categories
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

  def set_categories
    @main_categories = Category.where( sub: '0' )
    @sub_category = Category.where( sub: params[:id], sub_sub: params[:sub_sub])
    @sub_subcategories = Category.where( sub: params[:sub_sub], sub_sub: params[:sub] )
  end
end
