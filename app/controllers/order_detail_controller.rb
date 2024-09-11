class OrderDetailController < ApplicationController
  before_action :set_order_detail, only: [:show, :update, :destroy]

  # GET /order_details
  def index
    @order_details = OrderDetail.all
    render json: @order_details
  end

  # GET /order_details/:id
  def show
    render json: @order_detail
  end

  # POST /order_details
  def create
    @order_detail = OrderDetail.new(order_detail_params)
    if @order_detail.save
      render json: @order_detail, status: :created
    else
      render json: { errors: @order_detail.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /order_details/:id
  def update
    if @order_detail.update(order_detail_params)
      render json: @order_detail
    else
      render json: { errors: @order_detail.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /order_details/:id
  def destroy
    @order_detail.destroy
    render json: { message: 'Order detail deleted successfully' }, status: :ok
  end

  private

  # Set the order detail by ID
  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :product_id, :quantity, :total)
  end
end
