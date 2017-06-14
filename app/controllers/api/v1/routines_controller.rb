class Api::V1::RoutinesController < ApplicationController
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped

  def index
    routines = policy_scope(Routine)
    render json: routines, include: ['routine'], status: 200
  end

  def show
    routine = Routine.includes(:groups, :intervals).find(params[:id])
    render json: routine, include: ['groups.intervals'], status: 200
  end
end
