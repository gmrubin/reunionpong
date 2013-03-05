class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @posts = Forem::Post.last(5)
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new()
    @users = User.solo.where('id != ?', current_user.id)
  end

  def create
    @team = Team.new(params[:team])
    @team.add_user!(current_user)
    if @team.save and @team.users.count > 0
      flash[:notice] = "Awesome, you've got a team."
    else
      flash[:alert] = "Team already taken or some other problem. Try harder."
    end
    redirect_to @team
  end

  def join
    @team = Team.find(params[:id])
    current_user.update_attribute(:team_id, @team.id)
    redirect_to @team
  end

  def leave
    @team = Team.find(params[:id])
    if @team.users.count > 1
      current_user.update_attribute(:team_id, nil)
      redirect_to teams_path
    else
      flash[:alert] = "Not so fast, you need to leave at least one player on this team."
      redirect_to @team
    end
  end

end
