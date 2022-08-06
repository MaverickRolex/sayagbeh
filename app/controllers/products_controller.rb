class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    
  end

  def edit

  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:notice] = "Producto creado."
      redirect_to @product
    else
      flash.now[:alert] = "Error al crear el producto."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      flash.now[:notice] = "Los cambios han sido guardados."
      redirect_to @product
    else
      flash.now[:alert] = "Error al editar el producto."
      render :show
    end
  end 

  def destroy
    if current_user.admin
      if @product.destroy
        flash.now[:notice] = "Producto eliminado con exito."
        redirect_to action: "index"
      end
    else
      flash.now[:alert] = "No tiene permisos para eliminar productos, contacte al administrador."
      render :show
    end
  end

  def search
    product = Product.find_by(code: params[:search][:code].upcase)
    redirect_to new_sale_path(product_id: product.id)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:code, :name, :description, :ingredients, :price, :stock)
  end
end
