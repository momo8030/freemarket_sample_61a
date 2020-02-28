class ItemsController < ApplicationController
  def index
  end

  def show
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
