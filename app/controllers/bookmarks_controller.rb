class BookmarksController < ApplicationController
  before_action :set_list, only: [ :index, :new, :create, :destroy ]

  def index
    @bookmarks = Bookmark.where(list_id: @list)
  end

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'new'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
