class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/:id
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /orders/:id
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  def destroy
    @order.destroy
    render json: { message: 'Order deleted successfully' }, status: :ok
  end

  private

  # Set the order by ID
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def order_params
    params.require(:order).permit(:user_id, :created_at2, :status, :total)
  end
end
