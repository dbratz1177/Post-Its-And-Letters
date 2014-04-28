class UserpageController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  before_action :user_session
  #For now, made the homepage only accessible to people who
  #are signed in. Done in the filter above.


  def home
    @pageOwner = homepage_setup
    if @pageOwner.nil?
      send_home(session[:username],true)
      return
    end
    @visitingUser = current_user
    @myPage = isMyPage?
    noteBoard = @pageOwner.noteboard
    @notes = noteBoard.notes
  end

  private

  def homepage_setup
    if params[:username].nil?
      return nil
    end
    owner = User.find_by(username: params[:username])
    if owner.nil?
      flash[:error] = "Sorry, that users page doesn't exist"
      return nil
    end
    owner
  end
end
