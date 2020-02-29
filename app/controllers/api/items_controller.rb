class Api::ItemsController < ApplicationController
  def new
    @sizes = Size.where(group: params[:group])
  end
  def new_delivery
    @delivery_methods = DeliveryMethod.where(charge: params[:charge])
  end
end