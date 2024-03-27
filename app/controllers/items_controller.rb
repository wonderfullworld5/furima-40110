class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      puts @item.errors.full_messages

      redirect_to item_path(@item), notice: "商品が正常に出品されました。"

    else
      flash.now[:alert] = "商品の出品に失敗しました。入力内容を確認してください。"
      render :new
    end
  end

  private
    def item_params
    params.require(:item).permit(:image, :name, :description, :delivery_date_id, :condition_id, :postage_id, :area_id, :price)
    end
    end





