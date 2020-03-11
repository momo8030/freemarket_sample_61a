class ItemsController < ApplicationController
  def index
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

  private

  def item_params
    params.require(:item).permit(:name, :price, :comment, :condition_id, :category_id, :size_id, :delivery_charge_id, :prefecture_id, :delivery_days_id, :delivery_method_id, :brand, :buyer_id, :likes_count, images_attributes: [:url]).merge(seller_id: current_user.id)
  end

end
