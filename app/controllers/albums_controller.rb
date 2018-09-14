class AlbumsController < ApplicationController

  before_action :require_login, except: [:show]

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      flash[:errors] = ["Can't find album"]
      redirect_to bands_url
    end
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.find_by(id: params[:band_id])

    if @band
      @album = Album.new
      @album.band_id = params[:band_id]
      render :new
    else
      flash[:errors] = ["Can't find band"]
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    if @album
      render :edit
    else
      flash[:errors] = ['album not found']
      redirect_to albums_url
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    if @album
      band_id = @album.band_id
      @album.destroy
      redirect_to band_url(band_id)
    else
      flash[:errors] = ['album not found']
      redirect_to bands_url
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :is_live)
  end


end
