class UserpageController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  before_action :user_session
  #For now, made the homepage only accessible to people who
  #are signed in. Done in the filter above.

  def home
    @pageOwner = homepage_setup
    if @pageOwner.nil?
      redirect_to main_app.home_path(session[:username])
      return
    end
    @visitingUser = current_user
    @myPage = isMyPage?
    @noteBoard = @pageOwner.noteboard
    @notes = @noteBoard.notes
    #Used in the hidden fields
    @note = Noteboard::Note.new
    @note.poster_id = @visitingUser.id
    @note.noteboard_id = @noteBoard.id
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
