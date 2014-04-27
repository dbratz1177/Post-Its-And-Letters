class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:inside]

  def sitehome
  end

  def home
  end

  def inside
  end

end
