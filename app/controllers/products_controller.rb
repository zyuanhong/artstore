class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :add_to_cart]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    if @product.quantity > 0
      if current_cart.items.exclude?(@product)
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "你已成功將 #{@product.title} 加入購物車"
      else
        flash[:alert] = "你的購物車內已有此物品"
      end
    else
      flash[:alert] = "此物品已停止銷售，你無法將它加入購物車"
    end

    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
