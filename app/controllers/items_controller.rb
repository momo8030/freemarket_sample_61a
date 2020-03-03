class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images.order('id ASC')
    @seller = @item.seller
    @brand = @item.brand
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
