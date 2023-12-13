class MissionsController < ApplicationController
  before_action :set_listing
  before_action :set_mission, only: %i[show update destroy]

  def index
    @missions = @listing.missions
    render json: { missions: @missions }
  end

  def show
    render json: { mission: @mission }
  end

  def new
    @mission = @listing.missions.new
    render json: { mission: @mission }
  end

  def create
    @mission = @listing.missions.new(mission_params)
    if @mission.save
      render json: { mission: @mission }
    else
      render json: { errors: @mission.errors }, status: :unprocessable_entity
    end
  end

  def update

    if @mission.update(mission_params)
      render json: { mission: @mission }
    else
      render json: { errors: @mission.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @mission.destroy
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_mission
    @mission = @listing.missions.find(params[:id])
  end
end
