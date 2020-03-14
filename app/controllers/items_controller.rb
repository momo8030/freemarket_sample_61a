class ItemsController < ApplicationController
  
  before_action :set_card

  require 'payjp'

  def index

    @ladies_items = Item.where(category_id: 159..337).includes(:images).order('created_at DESC').limit(10)  #ladysカテゴリーの商品を１０件代入
    @mens_items = Item.where(category_id: 338..467).includes(:images).order('created_at DESC').limit(10)    #mensカテゴリーの商品を１０件代入
    @toys_items = Item.where(category_id: 765..865).includes(:images).order('created_at DESC').limit(10)    #おもちゃカテゴリーの商品を１０件代入
    @home_appliances_items = Item.where(category_id: 954..1028).includes(:images).order('created_at DESC').limit(10)   #家電カテゴリーの商品を１０件代入
    @chanel_items = Item.where('brand like?', '%シャネル%').includes(:images).order('created_at DESC').limit(10) #シャネルを含む商品を１０件代入
    @vuitton_items = Item.where('brand like?', '%ヴィトン%').includes(:images).order('created_at DESC').limit(10)  #ヴィトンを含む商品を１０件代入
    @supreme_items = Item.where('brand like?', '%シュプリーム%').includes(:images).order('created_at DESC').limit(10)  #シュプリームを含む商品を１０件代入
    @nike_items = Item.where('brand like?', '%ナイキ%').includes(:images).order('created_at DESC').limit(10) #ナイキを含む商品を１０件代入

    @items = Item.includes(:images).order('created_at DESC')

  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images.order('id ASC')
  end

  def new
    @item = Item.new
    @item.images.new
    @categories = Category.where(sub: params[:sub], sub_sub: params[:sub_sub])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
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
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: @item.price,
    card: params['payjp-token'],
    # 日本円
    currency: 'jpy' 
    )
    if 
      #購入者はupdate_attributeで引数に渡してDBにcurrent_user.idとbuyer_idを同時に登録
      @item.update_attribute(:buyer_id, current_user.id)
      redirect_to item_done_path
    else
      flash[:alert] = '購入に失敗しました。'
      render template: "items/show"
    end
    
  end

  def done
  end

  def destroy
    if @item.destroy
      redirect_to user_path
    else
      render :show,  alert: '削除に失敗しました'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :comment, :condition_id, :category_id, :size_id, :delivery_charge_id, :prefecture_id, :delivery_days_id, :delivery_method_id, :brand, :buyer_id, :likes_count, images_attributes: [:url, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_card
    @credit = Card.present?
  end
  

end
