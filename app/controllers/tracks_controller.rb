class TracksController < ApplicationController

  before_action :require_login, except: [:show]

  def show
    @track = Track.find_by(id: params[:id])
    if @track
      render :show
    else
      flash[:errors] = ["Can't find track"]
      redirect_to bands_url
    end
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      # render json: params
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.find_by(id: params[:album_id])

    if @album
      @track = Track.new
      @track.album_id = params[:album_id]
      @track.ord = @album.next_track_num
      render :new
    else
      flash[:errors] = ["Can't find band"]
      redirect_to album_url(params[:album_id])
    end
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    if @track
      render :edit
    else
      flash[:errors] = ['track not found']
      redirect_to bands_url
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    if @track
      album_id = @track.album_id
      @track.destroy
      redirect_to album_url(album_id)
    else
      flash[:errors] = ['track not found']
      redirect_to bands_url
    end
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :is_bonus, :lyrics)
  end


end
