class ProductsController < ApplicationController

 # GET /products
 def index
  @products = Product.all
  products_with_images = @products.map do |product|
    image_url = product.image.attached? ? url_for(product.image) : nil
    product.attributes.merge(image_url: image_url)
  end

  render json: products_with_images
end

# GET /products/:id
def show
  @product = Product.find(params[:id])
  render json: @product
end

 # POST /products
 def create
  @product = Product.new(product_params)

  if @product.save
    redirect_to @product, status: :ok

  else
    render :new
  end
end
# PUT /products/:id
def update
  @product = Product.find(params[:id])
  if @product.update(product_params)
    render json: @product, status: :ok
  else
    render json: @product.errors, status: :unprocessable_entity
  end
end

# DELETE /products/:id
def destroy
  @product = Product.find(params[:id])
  @product.destroy
  head :no_content
end

private

# Parámetros permitidos
def product_params
  params.require(:product).permit(:name, :description, :price, :stock, :image)
end
end
