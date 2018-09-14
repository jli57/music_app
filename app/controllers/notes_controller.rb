class NotesController < ApplicationController

  before_action :require_login, except: [:show]

  def show
    @note = Note.find_by(id: params[:id])
    if @note
      render :show
    else
      flash[:errors] = ["Can't find note"]
      redirect_to bands_url
    end
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(note_params[:track_id])
    end
  end

  def new
    @track = Track.find_by(id: params[:track_id])

    if @track
      @note = Note.new(track_id: params[:track_id])
      render :new
    else
      flash[:errors] = ["Can't find track"]
      redirect_to bands_url
    end
  end

  def update
    @note = Note.find_by(id: params[:id])
    if @note.update(note_params)
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :edit
    end
  end

  def edit
    @note = Note.find_by(id: params[:id])
    if @note
      if @note.user_id == current_user.id
        render :edit
      else
        render text: "UNAUTHORIZED ACTION", status: 403
      end
    else
      flash[:errors] = ['Note not found']
      redirect_to bands_url
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note
      if @note.user_id == current_user.id
        track_id = @note.track_id
        @note.destroy
        redirect_to track_url(track_id)
      else
        render text: "UNAUTHORIZED ACTION", status: 403
      end
    else
      flash[:errors] = ['Note not found']
      redirect_to bands_url
    end
  end

  private

  def note_params
    params.require(:note).permit(:note_text, :track_id)
  end

end
