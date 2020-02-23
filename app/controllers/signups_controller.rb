class SignupsController < ApplicationController

  def new
    @user = User.new
  end

  def phone_number
    @user = User.new
  end

  def done
    @user = User.new
  end

end