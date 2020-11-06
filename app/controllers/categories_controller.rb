class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.public_cat
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def add_subcategory
    @sub_category = Subcategory.new
  end

  def create_subcategory
    @sub_category = Subcategory.new(name: params[:name], category_id: params[:category_id])
    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to category_path(params[:category_id]), notice: 'SubCategory was successfully created.' }
        format.json { render :show, status: :created, location: @sub_category }
      else
        format.html { render :add_subcategory }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def category_detail
    if params[:name].present?
      category = Category.where(name: params[:name]).last
      if category.present?
        sub_categories = category.subcategories.pluck(:name) if category.subcategories.present?
        markers = category.markers.pluck(:name) if category.markers.present?
        if category.public_cat?
          render json: {
          category: category.name,
          sub_categories: sub_categories,
          markers: markers
          }
        else
          render json: {message: "Category is private"}
        end
      else
        render json: {message: "No record found."}
      end
      
    else
      render json: {message: "Please enter category name."}
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name,:status)
    end
end
