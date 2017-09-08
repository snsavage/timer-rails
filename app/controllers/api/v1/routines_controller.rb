class Api::V1::RoutinesController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]

  after_action :verify_authorized, except: [:index, :create]
  after_action :verify_policy_scoped, only: [:index]

  def index
    routines = policy_scope(Routine)
    render json: routines, include: ['routine'], status: 200
  end

  def show
    routine = Routine.includes(:groups, :intervals).find(params[:id])
    authorize routine

    render json: routine, include: ['groups.intervals'], status: 200
  end

  def create
    routine = current_user.routines.create(routine_params)

    if routine.valid?
      render json: routine, include: ['groups.intervals'], status: 201
    else
      render json: {}, status: 400
    end
  end

  def update
    routine = Routine.find(params[:id])
    authorize routine

    routine.update(routine_params)

    if routine.save
      render json: routine, include: ['groups.intervals'], status: 202
    else
      render json: {}, status: 400
    end
  end

  private

  def routine_params
    params.require(:routine).permit(
      :name, :description, :link, :public,
      groups_attributes: [
        :id, :order, :times, intervals_attributes: [
          :id, :name, :order, :duration
        ]
      ]
    )
  end
end
