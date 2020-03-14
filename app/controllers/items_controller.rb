class ItemsController < ApplicationController
  before_action :set_item,only: [:show,:show_mypage]
  def index
  end

  def show
     if user_signed_in?
       if @item.seller_id == current_user.id
         redirect_to show_mypage_items_path
       else
         show_item
       end
     else
       show_item
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end
  def show_mypage
    show_item
  end
  def show_item
    @images = @item.images.order('id ASC')
    @seller = @item.seller
    @brand = @item.brand
    @seller_items = Item.where(seller_id: @seller.id).order("id DESC").limit(6)
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

end
