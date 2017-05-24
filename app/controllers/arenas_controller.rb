class ArenasController < ApplicationController
  before_action :set_arena, only: [:show, :update, :destroy]

  # GET /arenas
  def index
    @arenas = Arena.all
    json_response(@arenas)
  end

  # POST /arenas
  def create
    @arena = Arena.create!(arena_params)
    json_response(@arena, :created)
  end

  # GET /arenas/:id
  def show
    json_response(@arena)
  end

  # PUT /arenas/:id
  def update
    @arena.update(arena_params)
    head :no_content
  end

  # DELETE /arenas/:id
  def destroy
    @arena.destroy
    head :no_content
  end

  private

  def arena_params
    # whitelist params
    params.permit(:battle_type)
  end

  def set_arena
    @arena = Arena.find(params[:id])
  end
end
