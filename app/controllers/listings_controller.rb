class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show update destroy]

  def index
    @listings = Listing.all
    render json: @listings
  end

  def show
    render json: @listing
  end

  def new
    @listing = Listing.new
    render json: @listing
  end

  def create
    @mission = Mission.new(listing_params)
    @listing = Listing.new(listing_params)
    if @listing.save
      render json: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  def update
    if @listing.update(listing_params)
      render json: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:num_rooms, :created_at, :updated_at, :mission_type, :price, :date)
  end
end
