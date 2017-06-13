class Api::V1::RoutinesController < ApplicationController
  # skip_before_action :authenticate

  def index
    routines = Routine.all
    render json: routines, include: ['routine'], status: 200
  end

  def show
    routine = Routine.includes(:groups, :intervals).find(params[:id])
    render json: routine, include: ['groups.intervals'], status: 200
  end
end
