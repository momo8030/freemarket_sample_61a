class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images.order('id ASC')
  end

  def new
  end

  def edit
  end

end
