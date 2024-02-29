class FavouritesController < ApplicationController
    skip_before_action :authenticate_user!, only: :show

  def index
    @favourites = policy_scope(Favourite)
  end

  def show
    @favourite = Favourite.find(params[:id])
    authorize @favourite
  end

  def create
    @car = Car.find(params[:car_id])
    @favourite = Favourite.new(car: @car, user: current_user)
    authorize @favourite
    @favourite.save
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    authorize @favourite
    @favourite.destroy
  end

  def delete_fav_index
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    authorize @favourite
    redirect_to favourites_path if @favourite.destroy
  end
end
