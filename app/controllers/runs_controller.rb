class RunsController < ApplicationController
  before_action :authenticate_user!

  def index
    @runs = current_user.runs
  end

  def new
    @run = Run.new
  end

  def create
    @run = current_user.runs.new(run_params)

    if @run.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @run = current_user.runs.find(params[:id])
  end

  private

  def run_params
    params.require(:run).permit(:date, :distance, :duration, :heart_rate, :cadence, :elevation, :hours, :minutes, :seconds)
  end
end
