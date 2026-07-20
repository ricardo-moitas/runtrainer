class RunsController < ApplicationController
  before_action :authenticate_user!

  def index
    @runs = current_user.runs
  end

  def new
    @run = Run.new
  end

  def create
    @run = Run.new(run_params)
    @run.user = current_user

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


class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

u1 = User.new("Ricardo")
u2 = User.new("João")

u1.name = "Pedro"

puts u1.name
puts u2.name
