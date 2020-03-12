class ItemsController < ApplicationController
  def index

    # @ladies_items = Item.where(category_id: 159..337).includes(:images).order('created_at DESC').limit(10)  #ladysカテゴリーの商品を１０件代入
    # @mens_items = Item.where(category_id: 338..467).includes(:images).order('created_at DESC').limit(10)    #mensカテゴリーの商品を１０件代入
    # @toys_items = Item.where(category_id: 765..865).includes(:images).order('created_at DESC').limit(10)    #おもちゃカテゴリーの商品を１０件代入
    # @home_appliances_items = Item.where(category_id: 954..1028).includes(:images).order('created_at DESC').limit(10)   #家電カテゴリーの商品を１０件代入
    # @chanel_items = Item.where('brand like?', '%シャネル%').includes(:images).order('created_at DESC').limit(10) #シャネルを含む商品を１０件代入
    # @vuitton_items = Item.where('brand like?', '%ヴィトン%').includes(:images).order('created_at DESC').limit(10)  #ヴィトンを含む商品を１０件代入
    # @supreme_items = Item.where('brand like?', '%シュプリーム%').includes(:images).order('created_at DESC').limit(10)  #シュプリームを含む商品を１０件代入
    # @nike_items = Item.where('brand like?', '%ナイキ%').includes(:images).order('created_at DESC').limit(10) #ナイキを含む商品を１０件代入

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
    binding.pry
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
