class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  def checkin
    @products = Product.all.order(:id)
    @charr = []
    @products.each do |p|
      @charr << Checkin.new(product_id: p.id, add_stock: 0)
    end
  end

  def product_checkin
    puts params
    puts checkin_params
    @checkin = Checkin.new(checkin_params)
    product = Product.find(@checkin.product_id)
    product.in_stock = product.in_stock + @checkin.add_stock
    respond_to do |format|
      if product.save
        format.html { redirect_to "/checkin", notice: "#{@checkin.add_stock} unit added to #{product.name}." }
        format.json { render :show, status: :accepted, location: @product }
      else
        format.html { render :checkin }
        format.json { render json: product.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.is_selling = false
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product stopped selling.' }
      format.json { head :no_content }
    end
    # @product.destroy
    # respond_to do |format|
    #   format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :buy_price, :sell_price, :in_stock)
    end

    def checkin_params
      params.require(:checkin).permit(:product_id, :add_stock)
    end
end
