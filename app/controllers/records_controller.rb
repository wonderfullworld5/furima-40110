class RecordsController < ApplicationController
  before_action :set_item

  def index
  end

  def new_order
    @purchase_form = PurchaseForm.new
    render 'index'  # index.html.erb
  end

  def create_order
    @purchase_form = PurchaseForm.new(purchase_form_params)
    if @purchase_form.save
      redirect_to success_item_records_item_records_path(@item), notice: '購入が完了しました。'
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_form_params
    params.require(:purchase_form).permit(:postcode, :area_id, :city, :street, :building, :phone).merge(user_id: current_user.id, item_id: @item.id)
  end
end

