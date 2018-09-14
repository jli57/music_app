class BandsController < ApplicationController

  before_action :require_login, except: [:index, :show]

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      flash[:errors] = ["Can't find band"]
      redirect_to bands_url
    end
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if @band
      render :edit
    else
      flash[:errors] = ['Band not found']
      redirect_to bands_url
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    if @band
      @band.destroy
      redirect_to bands_url
    else
      flash[:errors] = ['Band not found']
      redirect_to bands_url
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
