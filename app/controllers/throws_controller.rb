class ThrowsController < ApplicationController
  before_action :set_throw, only: [:show, :edit, :update, :destroy]

  # GET /throws
  # GET /throws.json
  def index
    @throws = Throw.all
  end

  # GET /throws/1
  # GET /throws/1.json
  def show
  end

  # GET /throws/new
  def new
    @throw = Throw.new
  end

  # GET /throws/1/edit
  def edit
  end

  # POST /throws
  def create
    @throw = Throw.new(throw_params)
    if @throw.save
      redirect_to @throw.frame.game
    else
      redirect_to @throw.frame.game, :flash => { :errors => @throw.errors.full_messages }
    end
  end

  # PATCH/PUT /throws/1
  # PATCH/PUT /throws/1.json
  def update
    respond_to do |format|
      if @throw.update(throw_params)
        format.html { redirect_to @throw, notice: 'Throw was successfully updated.' }
        format.json { render :show, status: :ok, location: @throw }
      else
        format.html { render :edit }
        format.json { render json: @throw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /throws/1
  # DELETE /throws/1.json
  def destroy
    @throw.destroy
    respond_to do |format|
      format.html { redirect_to throws_url, notice: 'Throw was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_throw
      @throw = Throw.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def throw_params
      params.require(:throw).permit(:pins, :frame_id)
    end
end
