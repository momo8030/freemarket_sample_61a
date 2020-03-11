class ItemsController < ApplicationController
  require 'payjp'
  before_action :set_card

  def index
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images.order('id ASC')
  end

  def new
    @items = Item.new
    @categories = Category.where(sub: params[:sub], sub_sub: params[:sub_sub])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def confirmation
    card = Card.where(user_id: current_user.id).first
    # テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      flash[:notice] = 'クレジットカードの登録して下さい'
      # redirect_to controller: "cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: 300,
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to action: :done
  end

  def done
  end

  private

  def set_card
    @credit = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end
