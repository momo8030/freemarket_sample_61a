class ItemsController < ApplicationController
  def index
    @ladies_items = Item.where(category_id: 1).includes(images).order("created_at", DESC).limit(10)  #ladysカテゴリーの商品を１０件代入
    @mens_items = Item.where(category_id: 2).includes(images).order("created_at", DESC).limit(10)    #mensカテゴリーの商品を１０件代入
    @toys_items = Item.where(category_id: 6).includes(images).order("created_at", DESC).limit(10)    #おもちゃカテゴリーの商品を１０件代入
    @home_appliances_items = Item.where(category_id: 8).includes(images).order("created_at", DESC).limit(10)   #家電カテゴリーの商品を１０件代入
    @chanel_items = Item.where('brands like?', '%シャネル%').includes(images).order("created_at", DESC).limit(10) #シャネルを含む商品を１０件代入
    @vuitton_items = Item.where('brands like?', '%ヴィトン%').includes(images).order("created_at", DESC).limit(10)  #ヴィトンを含む商品を１０件代入
    @supreme_items = Item.where('brands like?', '%シュプリーム%').includes(images).order("created_at", DESC).limit(10)  #シュプリームを含む商品を１０件代入
    @nike_items = Item.where('brands like?', '%ナイキ%').includes(images).order("created_at", DESC).limit(10) #ナイキを含む商品を１０件代入
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

end
