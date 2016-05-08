class AlbumsController < ApplicationController
  before_action :find_album, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    if params[:category].blank?
      @albums = Album.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @albums = Album.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def show
    if @album.reviews.blank?
      @average_review = 0
    else
      @average_review = @album.reviews.average(:rating).round(2)
    end
  end

  def new
    @album = current_user.albums.build
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def create
    @album = current_user.albums.build(album_params)
    @album.category_id = params[:category_id]
    if @album.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def update
    @album.category_id = params[:category_id]
    if @album.update(album_params)
      redirect_to album_path(@album)
    else
      render 'edit'
    end
  end

  def destroy
    @album.destroy
    redirect_to root_path
  end

  private

  def album_params
    params.require(:album).permit(:title, :artist, :description, :category_id, :album_image)
  end

  def find_album
    @album = Album.find(params[:id])
  end

end
