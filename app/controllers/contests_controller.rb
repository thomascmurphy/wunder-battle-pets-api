class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :update, :destroy]

  # GET /contests
  def index
    @contests = Contest.all
    json_response(@contests)
  end

  # POST /contests
  def create
    if contest_params[:discipline_id].blank? && params[:discipline_name].present?
      discipline = Discipline.find_by(name: params[:discipline_name])
      params[:discipline_id] = discipline.id if discipline.present?
    end
    @contest = Contest.find_by(contest_params)
    if @contest.blank?
      @contest = Contest.create!(contest_params)
    end
    json_response(@contest, :created)
  end

  # GET /contests/:id
  def show
    json_response(@contest)
  end

  # PUT /contests/:id
  def update
    @contest.update(contest_params)
    head :no_content
  end

  # DELETE /contests/:id
  def destroy
    @contest.destroy
    head :no_content
  end

  private

  def contest_params
    # whitelist params
    params.permit(:pet_1_id, :pet_2_id, :discipline_id)
  end

  def set_contest
    @contest = Contest.find(params[:id])
  end
end
