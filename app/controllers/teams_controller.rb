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
    @team.add_user!(current_user)
    flash[:alert] = "Awesome, you've got a partner"
    redirect_to @team
  end

  def join
    @team = Team.find(params[:id])
    current_user.update_attribute(:team_id, @team.id)
    redirect_to @team
  end

  def leave
    @team = Team.find(params[:id])
    current_user.update_attribute(:team_id, nil)
    redirect_to @team
  end

end
