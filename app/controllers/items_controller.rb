class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    
    
    
  end

  def edit
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end
end
