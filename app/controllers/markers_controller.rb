class MarkersController < ApplicationController
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  # GET /markers
  # GET /markers.json
  def index
    @markers = Marker.all
  end

  # GET /markers/1
  # GET /markers/1.json
  def show
  end

  # GET /markers/new
  def new
    @marker = Marker.new
    @categories = Category.all
    @types = Type.all
  end

  # GET /markers/1/edit
  def edit
    @categories = Category.all
    @types = Type.all
  end

  # POST /markers
  # POST /markers.json
  def create
    @marker = Marker.new(marker_params)
    @marker.categories.delete_all
    respond_to do |format|
      if @marker.save
        params[:marker][:categories_id].reject { |c| c.empty? }.each do |cat|
          cate = Category.find(cat)
          @marker.categories << cate
        end
        # format.html { redirect_to @marker, notice: 'Marker was successfully created.' }
        format.js { render layout: false }
      else
        format.html { render :new }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markers/1
  # PATCH/PUT /markers/1.json
  def update
    respond_to do |format|
      @marker.categories.delete_all
      if @marker.update(marker_params)
        params[:marker][:categories_id].reject { |c| c.empty? }.each do |cat|
          cate = Category.find(cat)
          @marker.categories << cate
        end
        format.html { redirect_to @marker, notice: 'Marker was successfully updated.' }
        format.json { render :show, status: :ok, location: @marker }
      else
        format.html { render :edit }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markers/1
  # DELETE /markers/1.json
  def destroy
    @marker.destroy
    respond_to do |format|
      format.html { redirect_to markers_url, notice: 'Marker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @marker = Marker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def marker_params
      params.require(:marker).permit(:name,:type_id)
    end
end
