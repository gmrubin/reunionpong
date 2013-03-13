class TeamsController < ApplicationController
  before_filter :correct_user, only: [:edit, :update]

  def index
    @teams = Team.all(order: 'city').sort_by {|t| t.users.count}
    @posts = Forem::Post.last(5)
    @partner = current_user.partner.name
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new()
    @users = User.solo.where('id != ?', current_user.id)
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "Successfully updated your Team"
    else
      flash[:alert] = "Error, sorry try again. Email reunionpong@gmail.com for help"
    end
    redirect_to @team
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
    @team.add_user!(current_user)
    flash[:notice] = "Awesome, you've got a team."
    redirect_to teams_path
  end

  def leave
    @team = Team.find(params[:id])
    if @team.users.count > 1
      @team.remove_user!(current_user)
      redirect_to teams_path
    else
      flash[:alert] = "Finish what you started, you need to have at least one player on this team."
      redirect_to @team
    end
  end

  private

    def correct_user
      @team = Team.find(params[:id])
      redirect_to(root_path) unless current_user.team == @team
    end
end
