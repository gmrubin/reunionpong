class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new()
  end

  def create
    @team = Team.new(params[:team])
    @team.save
    binding.pry
    @team.add_user!(current_user)
    flash[:alert] = "Awesome, you've got a partner"
    redirect_to @team
  end

end
