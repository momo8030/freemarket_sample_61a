class ItemsController < ApplicationController
  def index
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


  def show
    @item = Item.find(params[:id])
    @images = @item.images.order('id ASC')
  end

  def edit
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :price, :comment, :state, :category, :size, :postage, :region, :shopping_date, :buyer_id, :seller_id, :brand, images_attributes: [:url])
  end
end
