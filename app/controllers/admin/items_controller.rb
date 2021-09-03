class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.all.page(params[:page]).per(10)
    @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    # @item.user_id = current_user.id
    # byebug
    if @item.save
    redirect_to admin_items_path
    else
    @genres = Genre.all
    render :new
    end
  end

  def show
     @item = Item.find(params[:id])
  end

  def edit
    @genres = Genre.all
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    redirect_to admin_items_path
    else
    @genres = Genre.all
    render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active )
  end
end
