class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :update, :destroy]

  # GET /disciplines
  def index
    @disciplines = Discipline.all
    json_response(@disciplines)
  end

  # POST /disciplines
  def create
    @discipline = Discipline.create!(discipline_params)
    json_response(@discipline, :created)
  end

  # GET /disciplines/:id
  def show
    json_response(@discipline)
  end

  # PUT /disciplines/:id
  def update
    @discipline.update(discipline_params)
    head :no_content
  end

  # DELETE /disciplines/:id
  def destroy
    @discipline.destroy
    head :no_content
  end

  private

  def discipline_params
    # whitelist params
    params.permit(:name)
  end

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end
end
